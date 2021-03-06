class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = BookComment.new(book_comment_params)
    comment.book_id = book.id
    comment.user_id = current_user.id
    comment.save
    @book_comments = BookComment.all
    @user = book.user
  end

  def destroy
    book = Book.find(params[:book_id])
    comment = BookComment.find_by(book_id: book.id, id: params[:id])
    comment.destroy
  end

  private
  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
