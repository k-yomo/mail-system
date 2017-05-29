class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    @user = current_user
    @customers = current_user.customers.all
    @customers0 = current_user.customers.where(status: 0)
    @customers1 = current_user.customers.where(status: 1)
    respond_to do |format|
      format.html
      format.csv { send_data @customers.to_csv, filename: "customers-#{Date.today}.csv" }
    end
  end
end