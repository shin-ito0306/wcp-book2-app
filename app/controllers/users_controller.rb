class UsersController < ApplicationController

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def create

  end

  def show

  end

  def edit
    @user = User.find(params[:id])
  end



end
