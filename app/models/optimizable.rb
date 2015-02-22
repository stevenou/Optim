class Optimizable < ActiveRecord::Base
  belongs_to :optimizable_class
  delegate :project, :to => :optimizable_class, :allow_nil => true
  delegate :company, :to => :optimizable_class, :allow_nil => true
  has_many :optimizable_variants, :dependent => :destroy

  validates_uniqueness_of :reference_id, :scope => :optimizable_class_id, :case_sensitive => false
end
