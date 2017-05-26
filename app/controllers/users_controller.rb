class UsersController < ApplicationController


  def show
    @user = current_user
    @customers = current_user.customers
  end
end