class CreateBudgetItems < ActiveRecord::Migration[5.2]
  def change
    create_table :budget_items do |t|
      t.string :name
      t.integer :cost
      t.references :travel, foreign_key: true

      t.timestamps
    end
  end
end
