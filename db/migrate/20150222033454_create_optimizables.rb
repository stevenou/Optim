class CreateOptimizables < ActiveRecord::Migration
  def change
    create_table :optimizables do |t|
      t.integer :optimizable_class_id
      t.string :reference_id
      t.string :description
      t.integer :optimizable_variants_count, :null => false, :default => 0

      t.timestamps null: false
    end
  end
end
