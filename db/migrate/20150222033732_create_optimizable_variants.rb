class CreateOptimizableVariants < ActiveRecord::Migration
  def change
    create_table :optimizable_variants do |t|
      t.integer :optimizable_id
      t.string :url

      t.timestamps null: false
    end
  end
end
