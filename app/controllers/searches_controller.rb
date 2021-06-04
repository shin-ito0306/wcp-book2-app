class SearchesController < ApplicationController
  def search
    @range = params[:range]
    @word = params[:word]
    if @range == "User"
      @users = User.looks(params[:match], @word)
    else
      @books = Book.looks(params[:match], @word)
    end
  end
end
