class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(books_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  def show
  end

  def index
  end

  private
  def books_params
    params.require(:book).permit(:title, :body)
  end
end
