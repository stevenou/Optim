class UserPermission < ActiveRecord::Base
  belongs_to :user
  belongs_to :restrictable, :polymorphic => true
end
