class AddDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :picture, :string
    add_column :users, :introduce, :text
    add_column :users, :admin, :boolean
  end
end
