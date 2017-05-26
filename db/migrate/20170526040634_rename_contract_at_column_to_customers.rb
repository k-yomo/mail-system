class RenameContractAtColumnToCustomers < ActiveRecord::Migration[5.1]
  def change
    rename_column :customers, :contract_at, :applied_at
  end
end
