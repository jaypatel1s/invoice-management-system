# frozen_string_literal: true

# :nodoc:
class AddColumnInUser < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :branch, foreign_key: true
    add_column :users, :role, :integer
  end
end
