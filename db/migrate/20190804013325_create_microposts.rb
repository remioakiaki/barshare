class CreateMicroposts < ActiveRecord::Migration[5.2]
  def change
    create_table :microposts do |t|
      t.text :content
      t.json :pictures
      t.integer :likes_count,null:false,default:0
      t.string :title
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
