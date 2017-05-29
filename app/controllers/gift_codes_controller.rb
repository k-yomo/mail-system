class GiftCodesController < ApplicationController
  before_action :authenticate_user!, only: [:import]
  def index
    @gift_codes =  GiftCode.all
    @gift_codes0 = GiftCode.where(status: 0)
    @gift_codes1 = GiftCode.where(status: 1)
    respond_to do |format|
      format.html
      format.csv { send_data @gift_codes.to_csv, filename: "gift_Codes-#{Date.today}.csv" }
    end
  end

  def import
    if params[:csv_file].blank?
      flash[:danger] = "読み込むCSVを選択してください"
      redirect_to action: 'index'
    elsif File.extname(params[:csv_file].original_filename) != ".csv"
      flash[:danger] = "csvファイルのみ読み込み可能です"
      redirect_to action: 'index'
    else
      num = GiftCode.import_by_csv(params[:csv_file])
      flash[:success] =  "#{num.to_s}件のキャンンペーンコードを追加しました。"
      redirect_to action: 'index'
    end
  end

  def code_status
    @gift_code = GiftCode.find(params[:id])
    @gift_code.change_status(@gift_code)
    flash[:success] =  "#{@gift_code.code}のステータスを変更しました。"
    redirect_to action: 'index'
  end

  def send_gift
    @customer = Customer.find(params[:id])
    if GiftCode.where(status: 0).length < 1
      flash[:danger] =  "ギフトコードの数が足りません。"
      redirect_to users_path
    else
      send_mail(@customer)
      redirect_to users_path
    end
  end

  def send_gift_all
    @customers = current_user.customers.where(status: 0)
    if @customers.length > GiftCode.where(status: 0).length
      flash[:danger] =  "ギフトコードの数が足りません。"
      redirect_to users_path
    else
      @customers.each { |customer| send_mail(customer) }
      redirect_to users_path
    end
  end

  def send_mail(customer)
    @gift_code = GiftCode.where(status: 0).last
    GiftCodeMailer.send_gift_email(customer, @gift_code).deliver
    customer.update!(status: 1, gift_code: @gift_code)
    @gift_code.update!(status: 1,
                       customer_id: customer.id,
                       user_id: customer.user.id,
                       sent_at: DateTime.now)
    flash[:success] =  "#{customer.name}様にキャンペーンコードを送付しました。"
  end
end
