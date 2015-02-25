class Optimizable < ActiveRecord::Base
  def self.policy_class
    OptimizablePolicy
  end

  belongs_to :optimizable_class
  delegate :project, :to => :optimizable_class, :allow_nil => true
  delegate :company, :to => :optimizable_class, :allow_nil => true
  has_many :optimizable_variants, :dependent => :destroy, :inverse_of => :optimizable
  counter_culture [:optimizable_class, :project]
  counter_culture [:optimizable_class]

  validates_uniqueness_of :reference_id, :scope => :optimizable_class_id, :case_sensitive => false
  validates_presence_of :optimizable_class, :reference_id, :optimizable_variants

  accepts_nested_attributes_for :optimizable_variants, :allow_destroy => true, :reject_if => Proc.new{|n| n["url"].blank? }
  accepts_nested_attributes_for :optimizable_class

  def choose(selected_variant_id:, category: nil, do_not_track: false)
    if selected_variant_id && self.optimizable_variant_ids.include?(selected_variant_id)
      variant = self.optimizable_variants.find(selected_variant_id)
    else
      variant = Algorithm::Ucb.new.choose_variant(optimizable: self, category: category)
      unless do_not_track
        variant.increment_participants
      end
    end
  end

  def best_variant(category)
    best = nil
    best_rate = nil
    self.optimizable_variants.each { |variant|
      rate = variant.conversion_rate(category)
      if best_rate.nil? or rate > best_rate
        best = variant
        best_rate = rate
      end
    }

    return best
  end
  memoize :best_variant

  def worst_variant(category)
    worst = nil
    worst_rate = nil
    self.optimizable_variants.each { |variant|
      rate = variant.conversion_rate(category)
      if worst_rate.nil? or rate < worst_rate
        worst = variant
        worst_rate = rate
      end
    }

    return worst
  end
  memoize :worst_variant

  def improvement(category)
    if best_variant(category) && best_variant(category).conversion_rate && best_variant(category).conversion_rate > 0 &&
      worst_variant(category) && worst_variant(category).conversion_rate && worst_variant(category).conversion_rate > 0
      (best_variant(category).conversion_rate - worst_variant(category).conversion_rate) / worst_variant(category).conversion_rate
    else
      0
    end
  end
end
