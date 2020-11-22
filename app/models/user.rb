class User < ApplicationRecord
  before_save { self.email.downcase! }
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, #正規表現、入力されたメールアドレスが正しい形式になっているかの判定
    uniqueness: { case_sensitive: false } #uniquenessは重複を許さないバリデーション、 case_sensitive の false は大文字小文字を区別しない
  
  has_secure_password #railsの標準機能であり、password_digestカラムを検知して、パスワード保存の際に暗号化する。
                      #自動でログイン認証用のメソッド authenticate を提供する。
                      #なお、暗号化にはgem bcryptが必要。Gemfileに初期記載されているがコメントアウトされているので有効化する。
                      
  has_many :microposts
     
    
end
