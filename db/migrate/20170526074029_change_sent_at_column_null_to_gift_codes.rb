class ChangeSentAtColumnNullToGiftCodes < ActiveRecord::Migration[5.1]
  def change
    change_column_null :gift_codes, :sent_at, true
  end
end
