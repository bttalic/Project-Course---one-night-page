class AddCoursecodeToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :coursecode, :string
  end
end
