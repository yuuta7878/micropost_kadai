class UsersController < ApplicationController
    # require_user_logged_inは、ログインしていれば何もせず、ログインしていなければログインページに強制的にリダイレクトされる。
  before_action :require_user_logged_in, only: [:index, :show, :followers, :followings, :favorites, :microposts]
    # 全ユーザ一覧が欲しいのでUser.allで取得、ページネーション適用に必要な記述も追加
  def index
    @users = User.all.page(params[:page])
  end

  def show # Micropostsも表示する
    @user = User.find(params[:id])
    @microposts = @user.microposts.order('created_at DESC').page(params[:page])
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  
    if @user.save
      flash[:success] = 'ユーザを登録しました'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました'
      render.new
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.followings.page(params[:page])
    counts(@user)
  end
    
  def followers
    @user = User.find(params[:id])
    @followers = @user.followers.page(params[:page])
    counts(@user)      
  end
  
  def microposts
    @user = User.find(params[:id])
    @microposts = @user.microposts.page(params[:page])
    counts(@user)
  end

  def favorite
    @user = User.find(params[:id])
    @favorites = @user.favorites.page(params[:page])
    counts(@user)
  end

  private

  def user_params
      # password_confirmationは、パスワードの確認のために使用される
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end

















