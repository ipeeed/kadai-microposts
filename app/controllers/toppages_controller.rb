class ToppagesController < ApplicationController
  def index
    if logged_in?
      @micropost = current_user.microposts.build #form_with用（modelとして使う）
      @microposts = current_user.microposts.order(id: :desc).page(params[:page]) #一覧表示用
    end
  end
end
