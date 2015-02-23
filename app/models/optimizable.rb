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
end
