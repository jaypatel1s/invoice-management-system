# frozen_string_literal: true

# :nodoc:
class CreateBranches < ActiveRecord::Migration[7.0]
  def change
    create_table :branches do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name, null: false
      t.string :code
      t.string :address
      t.string :phone
      t.string :email

      t.timestamps
    end
  end
end
