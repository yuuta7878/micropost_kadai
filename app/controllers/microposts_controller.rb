class MicropostsController < ApplicationController
  # MicropostsController の全アクションはログインが必須になる
  before_action :require_user_logged_in
  # 下記によってdestroyアクションが実行される前にcorrect_userが実行される。
  before_action :correct_user, only: [:destroy]
  
  def create # メッセージの投稿機能
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @microposts = current_user.microposts.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy # 投稿削除機能
    @micropost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path) # このアクションが実行されたページに戻るメソッド 戻るべきページがない場合には root_path に戻る仕様
  end
  
  private
  
  def micropost_params
    params.require(:micropost).permit(:content)
  end  
  
  def correct_user # 削除するMicropostが本当にログインユーザが所有しているものか確認している。
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost # 判定処理　nilかfalseの時に実行される。
      redirect_to root_url # トップページに戻す処理　=>　保険のようなもの
    end
  end
end



