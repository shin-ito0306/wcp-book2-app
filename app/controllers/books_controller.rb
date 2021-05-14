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
    @book = current_user.books.new(book_params)
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice] = "successfully"
    else
      @books = Book.all
      @user = User.find(current_user.id)
      render :index

    end
  end

  def show
    @book_show = Book.find(params[:id])
    @user = User.find(@book_show.user.id)
    @book = Book.new
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user_id == current_user.id
      render :edit
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if  @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:notice] = "successfully"
    else
      render :edit
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
