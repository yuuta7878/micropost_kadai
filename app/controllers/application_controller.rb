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
  def counts(user)
    @count_microposts = user.microposts.count
    @count_followings = user.followings.count
    @count_followers = user.followers.count
  end
end