class CreateGiftCodes < ActiveRecord::Migration[5.1]
  def change
    create_table :gift_codes do |t|
      t.string :code, unique: true
      t.references :user, foreign_key: true
      t.references :customer, foreign_key: true
      t.integer :status, default: 0
      t.datetime :sent_at, null: false

      t.timestamps
    end
  end
end
