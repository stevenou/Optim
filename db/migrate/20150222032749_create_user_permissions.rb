class CreateUserPermissions < ActiveRecord::Migration
  def change
    create_table :user_permissions do |t|
      t.integer :user_id
      t.references :restrictable, :polymorphic => true
      t.string :role

      t.timestamps null: false
    end
  end
end
