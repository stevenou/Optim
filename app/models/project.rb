class Project < ActiveRecord::Base
  belongs_to :company
  has_many :user_permissions, :dependent => :destroy, :as => :restrictable
  has_many :users, :through => :user_permissions
  has_many :optimizable_classes, :dependent => :destroy, :counter_cache => true
  has_many :optimizables, :through => :optimizable_classes, :counter_cache => true
  has_many :optimizable_variants, :through => :optimizables, :counter_cache => true

  validates_uniqueness_of :name, :scope => :company_id, :case_sensitive => false
  validates_uniqueness_of :subdomain
  validates_presence_of :name, :subdomain
end
