class ApplicationController < ActionController::Base
  
  include SessionsHelper #Controllerでは、デフォルトでヘルパーを適用できない。includeでmodule追加。
  
  private
  
  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
  
  def counts(user)
    @count_microposts = user.microposts.count
  end
  
end
