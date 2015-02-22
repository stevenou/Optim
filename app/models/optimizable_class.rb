class OptimizableClass < ActiveRecord::Base
  belongs_to :project
  delegate :company, :to => :project, :allow_nil => true
  has_many :optimizables, :dependent => :destroy
  has_many :optimizable_variants, :through => :optimizables

  validates_uniqueness_of :name, :scope => :project_id, :case_sensitive => false
end
