class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.integer :subscription_plan_id

      t.timestamps null: false
    end
  end
end
