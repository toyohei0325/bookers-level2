class BooksController < ApplicationController
  before_action :correct_book, only: [:edit, :update]
  def new
  end

  def create
    @book = Book.new(books_params)
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have created book successfully."
    redirect_to book_path(@book.id)
    else
    @user = current_user
    @books = Book.all
    # 失敗した場合、renderでindexページを表示するようにしてあるからindexアクションを経由しない。
    # なので、もう一度indexアクションで定義したインスタンス変数を定義する必要がある。
    # しかし、indexアクションで定義した@book = Book.newはいらない。
    # なぜかというと投稿に失敗した場合、else以降の処理が実行されるのでelse以降に@book = Book.newが
    # あるとエラー文が入っていない空のインスタンスが代入された@book(_list.html.erbではbook)が送られてしまう
    # のでエラーメッセージが表示されなくなってしまう。
    render 'books/index'
    end
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
    @book_new = Book.new
    # ここで定義してある@userと@bookは部分テンプレートのインスタンス変数である。
    # @user = @book.userになるのはこの投稿をしたユーザーをUser infoのところに表示させたいからである。
    # @book_new = Book.newになるのはshowアクションでは@bookが既に定義されてあるのでかぶるのを防ぐためである。
  end

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
    # ここで定義してある@userと@bookは部分テンプレートのインスタンス変数である。
    # @user = current_userになる理由はUser infoのところは現在ログインしているユーザーを示している。
    # @book = Book.newになる理由はNew Bookのフォームに空のインスタンスを渡すためである。
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(books_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path(@book.id)
    else
    render 'books/edit'
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def books_params
    params.require(:book).permit(:title, :body)
  end

  def correct_book
    book = Book.find(params[:id])
    if current_user.id != book.user_id
      redirect_to books_path
    end
  end

end
