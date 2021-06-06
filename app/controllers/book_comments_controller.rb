class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @comment = BookComment.new
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = @book.id
    comment.save

  end

  def destroy
    @book = Book.find(params[:book_id])
    @comment = BookComment.new
    book_destroy = BookComment.find_by(id: params[:id], book_id: params[:book_id])
    if book_destroy.user_id == current_user.id
      book_destroy.destroy
   else
     render book_path(@book.id)
   end
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
