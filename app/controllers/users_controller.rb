class UsersController < ApplicationController

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
  end


  def show
    @user = User.find(params[:id])
    @book = Book.new

    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_user_entry.each do |cu|
        @user_entry.each do |u|
          if cu.room_id == u.room_id
            @is_room = true
            @roomid = cu.room_id
          end
        end
      end
      if @is_room != true
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.id == current_user.id
      render :edit
    else
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id)
      flash[:notice] = "successfully"
    else
      render :edit
    end
  end

  def follows
    user = User.find(params[:user_id])
    @users = user.follower_user
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followed_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
