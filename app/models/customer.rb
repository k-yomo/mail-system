class Customer < ApplicationRecord
  belongs_to :user
  has_one :gift_code
end
