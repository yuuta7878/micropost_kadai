class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # ControllerからHelperのメソッドを使用可能にする処理
  include SessionsHelper
  # ログイン要求処理
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  # Micropostの数をカウント => View で表示するときのため
  # フォロー／フォロワー数のカウントを View で表示するとき、全ての Controller が使用できるように記述を追加する
  def counts(user)
    @count_microposts = user.microposts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
    @count_favorites = user.favorites.count
  end
end