class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :subdomain
      t.integer :company_id
      t.integer :optimizable_classes_count
      t.integer :optimizables_count
      t.integer :optimizable_variants_count

      t.timestamps null: false
    end
  end
end
