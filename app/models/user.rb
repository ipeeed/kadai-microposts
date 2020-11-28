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
  
  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many :favorites, dependent: :destroy
  has_many :likes, through: :favorites, source: :micropost
  
  
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id) # createはbuild + save
    end
  end
  
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id]) #[self.id]は、self.following_idsで得られる配列情報にデータ型を合わせるために配列に変換している。
  end                                                        #findだと一件だけになるためwhereなのだと思われる。
  
  def like(micropost)
    self.favorites.find_or_create_by(micropost_id: micropost.id)
  end
  
  def unlike(micropost)
    favorite = self.favorites.find_by(micropost_id: micropost.id)
    favorite.destroy if favorite
  end
  
  def liked?(micropost)
    self.likes.include?(micropost)
  end

  
    
end
