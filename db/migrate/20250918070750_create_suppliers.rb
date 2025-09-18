class CreateSuppliers < ActiveRecord::Migration[7.1]
  def change
    create_table :suppliers do |t|
      t.string :name
      t.string :gstin
      t.string :email
      t.string :phone
      t.text :address

      t.timestamps
    end
  end
end
