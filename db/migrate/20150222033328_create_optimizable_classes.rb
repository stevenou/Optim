class CreateOptimizableClasses < ActiveRecord::Migration
  def change
    create_table :optimizable_classes do |t|
      t.string :name
      t.integer :project_id

      t.timestamps null: false
    end
  end
end
