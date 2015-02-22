class Company < ActiveRecord::Base
  has_many :user_permissions, :dependent => :destroy, :as => :restrictable
  has_many :users, :through => :user_permissions
  has_many :projects, :dependent => :destroy
end
