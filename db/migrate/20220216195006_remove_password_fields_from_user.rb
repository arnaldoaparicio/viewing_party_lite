class RemovePasswordFieldsFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :password, :string
    remove_column :users, :password_confirmation, :string
    add_column :users, :password_digest, :string
  end
end
