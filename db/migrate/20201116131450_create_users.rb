class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest #暗号化された文字列をダイジェストと呼ぶ。パスワード保存の際、
                                #このカラムにダイジェストとして保存するためこの名称とする。

      t.timestamps
    end
  end
end
