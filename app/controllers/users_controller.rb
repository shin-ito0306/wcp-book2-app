class UsersController < ApplicationController

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
  end




  def show
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(params[:id])
  end



end
