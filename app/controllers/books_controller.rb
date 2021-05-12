class BooksController < ApplicationController

  def index
    @users = User.all
    @user = User.find(current_user.id)
    @book = Book.new
    @books = Book.all
  end

  def new
    @book = Book.new
  end

  def create
    book = current_user.books.new(book_params)
    book.save
    redirect_to book_path(book.id)
  end

  def show
    @book_show = Book.find(params[:id])
    
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
