class CreateOptimizableClasses < ActiveRecord::Migration
  def change
    create_table :optimizable_classes do |t|
      t.string :name
      t.integer :project_id
      t.integer :optimizables_count, :null => false, :default => 0
      t.integer :optimizable_variants_count, :null => false, :default => 0

      t.timestamps null: false
    end
  end
end
