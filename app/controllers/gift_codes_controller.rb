class GiftCodesController < ApplicationController

  def index
    @gift_codes = GiftCode.all
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
      flash[:success] =  "#{ num.to_s }件のデータ情報を追加しました。"
      redirect_to action: 'index'
    end
  end
end
