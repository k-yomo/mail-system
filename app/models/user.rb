class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :customers
  has_many :gift_codes

  def Customer.to_csv
    options = { headers: true }
    CSV.generate(options) do |csv|
      csv << %w{ ステータス ユーザー名 メールアドレス 契約ID 申し込み日時 送付コード 送付日時}
      all.each do |customer|
        csv << [customer.status,
                customer.name,
                customer.email,
                customer.contract_id,
                customer.applied_at,
                customer.try(:gift_code).try(:code),
                customer.try(:gift_code).try(:sent_at)]
      end
    end
  end
end
