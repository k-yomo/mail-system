require 'csv'
class GiftCode < ActiveRecord::Base
  belongs_to :user, optional: true
  belongs_to :customer, optional: true

  validates :code, presence: true, uniqueness: true

  #csvファイルの内容をDBに登録する

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
        #登録済みデータ情報
        #登録されてなければ作成
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

end
