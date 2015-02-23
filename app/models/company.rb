class Company < ActiveRecord::Base
  has_many :user_permissions, :dependent => :destroy, :as => :restrictable
  has_many :users, :through => :user_permissions
  has_many :projects, :dependent => :destroy

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false
end
