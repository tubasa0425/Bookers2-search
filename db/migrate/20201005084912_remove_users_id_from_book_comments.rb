class RemoveUsersIdFromBookComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :book_comments, :users_id, :integer
  end
end
