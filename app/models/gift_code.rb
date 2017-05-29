require 'csv'
class GiftCode < ActiveRecord::Base
  belongs_to :user, optional: true
  belongs_to :customer, optional: true
  validates :code, presence: true, uniqueness: true


  def change_status(gift_code)
    if gift_code.status == 0
    gift_code.update!(status: 1)
    elsif gift_code.status == 1
    gift_code.update!(status: 0)
    end
  end

  def self.import_by_csv(file)
    imported_num = 0
    open(file.path, 'r:cp932:utf-8', undef: :replace) do |f|
      csv = CSV.new(f, headers: true)
      caches = GiftCode.all.index_by(&:code)
      csv.each do |row|

        next if row.header_row?

        #CSVの行情報をHASHに変換
        table = Hash[[row.headers, row.fields].transpose]
        code = table["code"]
        caches.each do |k,v|
          if  code != v
            gift_code = new(code: code)

            #バリデーションokの場合は保存
            if gift_code.valid?
              gift_code.save!
              imported_num += 1
              next
            end
          end
        end
      end
    end

    #更新件数を返す
    imported_num
  end

  def self.to_csv
    options = { headers: true }
    CSV.generate(options) do |csv|
      csv << %w{ ステータス コード ユーザー サイト 送付日時}
      all.each do |gift_code|
        csv << [gift_code.status,
                gift_code.code,
                gift_code.try(:customer).try(:name),
                gift_code.try(:user).try(:site_name),
                gift_code.try(:sent_at)]
      end
    end
  end
end
