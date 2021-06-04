class SearchesController < ApplicationController
  def search
    @range = params[:range]
    if @range == "User"
      @users = User.looks(params[:match], params[:word])
    else
      @books = Book.looks(params[:match], params[:word])
    end
  end
end
