class OptimizableClass < ActiveRecord::Base
  def self.policy_class
    OptimizablePolicy
  end
  
  belongs_to :project
  delegate :company, :to => :project, :allow_nil => true
  has_many :optimizables, :dependent => :destroy, :counter_cache => true
  has_many :optimizable_variants, :through => :optimizables

  validates_uniqueness_of :name, :scope => :project_id, :case_sensitive => false
  validates_presence_of :name
end
