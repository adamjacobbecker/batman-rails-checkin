class AddGithubParamsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login, :string
    add_column :users, :access_token, :string
    remove_columns :users, :password_digest
  end
end
