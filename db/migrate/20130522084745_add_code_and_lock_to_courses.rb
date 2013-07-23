class AddCodeAndLockToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :code, :string
    add_column :courses, :lock, :boolean
  end
end
