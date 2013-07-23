class AddOfficehoursToUsers < ActiveRecord::Migration
  def change
    add_column :users, :officehours, :string
  end
end
