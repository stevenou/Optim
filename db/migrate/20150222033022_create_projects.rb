class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :subdomain
      t.integer :company_id
      t.string :api_key
      t.integer :optimizable_classes_count, :null => false, :default => 0
      t.integer :optimizables_count, :null => false, :default => 0
      t.integer :optimizable_variants_count, :null => false, :default => 0

      t.timestamps null: false
    end
  end
end
