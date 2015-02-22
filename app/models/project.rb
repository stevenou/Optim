class Project < ActiveRecord::Base
  belongs_to :company
  has_many :user_permissions, :dependent => :destroy, :as => :restrictable
  has_many :users, :through => :user_permissions
  has_many :optimizable_classes, :dependent => :destroy
  has_many :optimizables, :dependent => :destroy

  validates_uniqueness_of :name, :scope => :company_id, :case_sensitive => false
  validates_uniqueness_of :subdomain
end
