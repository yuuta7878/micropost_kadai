# マイグレーションファイル # 2017/12/6 yuuta tomatsu
class CreateRelationships < ActiveRecord::Migration[5.0]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.references :follow, foreign_key: { to_table: :users } # { to_table: :users } によって、外部キーとして参照すべきテーブルを指定

      t.timestamps
      
      t.index [:user_id, :follow_id], unique: true #　フォローの重複保存の回避
    end
  end
end
