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
    if book.save
      redirect_to book_path(book.id)
      flash[:notice] = "success"
    else
      render books_path
      flash[:notice] = "error"
    end
  end

  def show
    @book_show = Book.find(params[:id])
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if  @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:notice] = "success"
    else
      render edit_book_path(@book.id)
      flash[:notice] = "error"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
