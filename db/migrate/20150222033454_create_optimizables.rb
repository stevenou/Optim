class CreateOptimizables < ActiveRecord::Migration
  def change
    create_table :optimizables do |t|
      t.integer :optimizable_class_id
      t.string :reference_id
      t.string :description

      t.timestamps null: false
    end
  end
end
