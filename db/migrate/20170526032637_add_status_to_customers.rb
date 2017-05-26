class AddStatusToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :status, :integer, default: 0
  end
end
