class CustomersController < ApplicationController
  before_action :set_customer, only: [:edit, :update, :destroy]
  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash[:success] = "キャンペーンのお申し込みが完了しました。"
       redirect_to customers_path
    else
      render :new
      flash[:danger] = "情報に誤りがあります。再度ご入力ください。"
    end
  end

  def edit
  end

  def update
    @customer.update(customer_params)
    flash[:success] = "ユーザー情報を変更しました。"
    redirect_to users_path
  end

  def destroy
    if @customer.status == 1
      @customer.destroy
      flash[:success] = "顧客情報を削除しました。"
      redirect_to users_path
    else
      flash[:danger] = "ギフトコード未送信ユーザーです。"
      render index
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :contract_id, :applied_at, :user_id)
  end
end
