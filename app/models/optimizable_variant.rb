class OptimizableVariant < ActiveRecord::Base
  belongs_to :optimizable
  delegate :optimizable_class, :to => :optimizable, :allow_nil => true
  delegate :project, :to => :optimizable, :allow_nil => true
  delegate :company, :to => :optimizable, :allow_nil => true

  validates_uniqueness_of :name, :scope => :optimizable_id, :case_sensitive => false
end
