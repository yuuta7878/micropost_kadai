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
end
