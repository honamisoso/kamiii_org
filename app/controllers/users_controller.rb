class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  def index
    @users = User.all
    @book = Book.new
  end
  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end
  def edit
    @user = User.find(params[:id])
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
      render :edit
    end
  end
  # def create
  #   # １.&2. データを受け取り新規登録するためのインスタンス作成
  #   user = User.new(book_params)
  #   # 3. データをデータベースに保存するためのsaveメソッド実行
  #   user.save
  #   # 4. トップ画面へリダイレクト
  #   redirect_to '/top'
  # end
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
   def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
    redirect_to user_path(current_user)
    end
   end
end
