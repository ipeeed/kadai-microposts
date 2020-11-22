class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.string :content
      t.references :user, foreign_key: true #実際のデータベース内ではuser_idカラムとして存在する。

      t.timestamps
    end
  end
end
