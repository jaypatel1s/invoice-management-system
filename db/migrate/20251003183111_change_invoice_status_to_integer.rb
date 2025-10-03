# frozen_string_literal: true

# :nodoc:
class ChangeInvoiceStatusToInteger < ActiveRecord::Migration[6.1]
  def up
    # Add new integer column with default draft (0)
    add_column :invoices, :status_int, :integer, default: 0, null: false

    # Map old string values to integer
    Invoice.reset_column_information
    Invoice.find_each do |invoice|
      invoice.update_column(:status_int, case invoice.status
                                         when 'draft' then 0
                                         when 'sent' then 1
                                         when 'paid' then 2
                                         when 'overdue' then 3
                                         when 'cancelled' then 4
                                         else 0
                                         end)
    end

    # Remove old string column and rename new column
    remove_column :invoices, :status
    rename_column :invoices, :status_int, :status
  end

  def down
    add_column :invoices, :status_string, :string
    Invoice.reset_column_information
    Invoice.find_each do |invoice|
      invoice.update_column(:status_string, Invoice.statuses.key(invoice.status))
    end
    remove_column :invoices, :status
    rename_column :invoices, :status_string, :status
  end
end
