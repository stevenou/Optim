class OptimizableVariant < ActiveRecord::Base
  def self.policy_class
    OptimizablePolicy
  end
  
  belongs_to :optimizable
  delegate :optimizable_class, :to => :optimizable, :allow_nil => true
  delegate :project, :to => :optimizable, :allow_nil => true
  delegate :company, :to => :optimizable, :allow_nil => true
  counter_culture [:optimizable, :optimizable_class, :project]
  counter_culture [:optimizable, :optimizable_class]
  counter_culture [:optimizable]

  validates_uniqueness_of :url, :scope => :optimizable_id, :case_sensitive => false
  validates_presence_of :optimizable
end
