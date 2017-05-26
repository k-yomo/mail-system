class CustomersController < ApplicationController


  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(user_params)
    if @customer.save
      flash[:success] = "キャンペーンのお申し込みが完了しました。"
       redirect_to customers_path
    else
      render :new
      flash[:danger] = "情報に誤りがあります。再度ご入力ください。"
    end
  end

  private

  def user_params
    params.require(:customer).permit(:name, :email, :contract_id, :contract_at, :user_id)
  end
end
