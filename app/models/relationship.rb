# Relationship Model :followについての補足設定
class Relationship < ApplicationRecord
  belongs_to :user
  belongs_to :follow, class_name: 'User' # followがFollowという存在しないクラスを参照することを防ぎ、User クラスであることを明示している。
  
  validates :user_id, presence: true
  validates :follow_id, presence: true
end
