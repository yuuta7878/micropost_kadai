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
end