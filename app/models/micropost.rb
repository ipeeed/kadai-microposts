class Micropost < ApplicationRecord
  belongs_to :user #この関連付けにより、Micropostモデルのインスタンス内でインスタンスメソッドuserが使用可能。そのmicropostインスタンスの紐づくuserインスタンスを取得できる。
                   #同時に、Userモデルのrubyファイルで規定したhas_manyにより、特定のuserインスタンスでmicropostsメソッド実行により、そのインスタンスに紐づく全投稿を取得できる。  
  validates :content, presence: true, length: { maximum: 255 }
  
  has_many :favorites, dependent: :destroy
  has_many :attracteds, through: :favorites, source: :user
  
end
