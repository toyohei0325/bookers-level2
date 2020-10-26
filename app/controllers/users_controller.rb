class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def index
    @user = current_user
    @users = User.all
    @book = Book.new
    # ここで定義してある@userと@bookは部分テンプレートのインスタンス変数である。
    # @user = current_userになる理由はUser infoのところは現在ログインしているユーザーを示している。
    # @book = Book.newになる理由はNew Bookのフォームに空のインスタンスを渡すためである。
  end

  def show
    @user = User.find(params[:id])
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
    redirect_to user_path(@user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(users_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else render 'users/edit'
    end
  end

  private
  def users_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    user = User.find(params[:id])
    if current_user.id != user.id
      redirect_to user_path(current_user.id)
    end
  end


end
