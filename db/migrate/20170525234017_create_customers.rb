class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.integer :contract_id
      t.datetime :contract_at
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
