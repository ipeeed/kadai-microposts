class SessionsController < ApplicationController
  def new #対応するモデルがないのでコードの追加は特になし。モデルなしでどうやってログインを行う？データベースに保存なし？
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    
    if login(email, password)
      flash[:success] = 'ログインに成功しました。'
      redirect_to @user
    else
      flash[:danger] = 'ログインに失敗しました。'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url # <-_urlを忘れない！
  end
  
  
  
  private
  
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)  # &&以前の if @userで、User.find_by(email: email)で検索した結果の有無を判定している。見つかっていなければ@userにはnilが代入されている。
      session[:user_id] = @user.id            # authenticateはhas_secure_passwordで提供される、ログイン認証用メソッド。userモデル内で定義している。
      return true                             # &&はrubyの論理演算子。 &&はand, ||はor, !はnot
    else                                      # sessionハッシュに保存することでブラウザにはCookieとして、サーバにはSessionとしてログイン状態が維持される。
      return false
    end
  end
    
end
