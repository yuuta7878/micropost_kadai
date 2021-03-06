class User < ApplicationRecord
  # 保存する前に { ○○をする }
  # self.email.downcase! → メールアドレスに、もし大文字（例えば M とか）があれば、これを強制的に小文字（例えば m とか）に変換する
  before_save { self.email.downcase! }
  # nameのバリデーション　カラを許さず５０文字以内
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },

                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  # ユーザモデルに書くことによって、主語が「ユーザー」と特定できます
  # よって、「ユーザーが」「複数の」「マイクロポストを」保持  できるという意味になります
  has_many :microposts
  has_many :relationships
  has_many :favorites
  # user.followingsと書けば、user がフォローしているUser達を取得できるようにする機能を提供する。
  # 中間テーブル(Relationship)から先のモデルを参照してくれるので、 User から直接、多対多の User 達を取得することができる
  has_many :followings, through: :relationships, source: :follow
  # 逆方向
  has_many :reverses_of_relationship, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverses_of_relationship, source: :user
  
  has_many :favorited, through: :favorites, source: :micropost
  #　フォローとアンフォローの注意点
  # 自分自身ではないか / 既にフォローしているか
  
  # フォロー機能
  # => フォローしようとしている「other_user」が自分自身ではないかを検証している。
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end  
  
  # アンフォロー機能
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end
  
  def following?(other_user)
    self.followings.include?(other_user)
  end
  
   # お気に入り追加機能
  def favorite(micropost)
    self.favorites.find_or_create_by(micropost_id: micropost.id)
  end

  # お気に入り解除機能
  def unfavorite(micropost)
    favorite = self.favorites.find_by(micropost_id: micropost.id)
    favorite.destroy if favorite
  end

  def favorite?(micropost)
    self.favorited.include?(micropost)
  end

  # タイムライン用のマイクロポストを取得するためのメソッド
  def feed_microposts
    Micropost.where(user_id: self.following_ids + [self.id]) # Micropost.where(user_id: フォローユーザ + 自分自身) となる Micropost を全て取得し
  end
end
