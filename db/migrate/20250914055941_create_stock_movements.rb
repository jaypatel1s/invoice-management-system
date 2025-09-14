class CreateStockMovements < ActiveRecord::Migration[7.1]
  def change
    create_table :stock_movements do |t|
      t.references :branch, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, null: false
      t.integer :movement_type, null: false, default: 0 # default :adjustment
      t.string :reference_type
      t.bigint :reference_id

      t.timestamps
    end

    add_index :stock_movements, [:reference_type, :reference_id]
  end
end
