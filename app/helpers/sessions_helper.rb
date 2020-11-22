module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) # find(session[:use_id])にしないのは、find_byだと該当ページが存在しない場合にnilを返すだけなのに対し、find(id)だとエラーとなるため。
  end                                                     # users#showの場合は存在しないというのはまずあり得ないが、ログインであれば入力ミスも含め大いにありうることなので、いちいちエラーでは成り立たない。

=begin  

上記の || の部分は、以下のコード全体を省略表記したもの。
ifに変数を単独でおけば、内容がnilであればfalseが返るものと思われる。
 if @current_user
   return @current_user
 else
  @current_user = User.find_by(id: session[:user_id])
  return @current_user
 end
 
=end
  
  def logged_in?
    !!current_user
  end
  
=begin

上記のダブル!は、下記のコードを省略表記したもの。
current_user単独だと判定にならないので論理演算子で強制的に判定をさせ、trueかfalseを返させている。
 if current_user
  return true
 else
  return false
 end

=end
end


