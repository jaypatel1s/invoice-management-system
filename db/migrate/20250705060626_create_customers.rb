# frozen_string_literal: true

# :nodoc:
class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.references :company, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :phone
      t.string :email
      t.string :address

      t.timestamps
    end
  end
end
