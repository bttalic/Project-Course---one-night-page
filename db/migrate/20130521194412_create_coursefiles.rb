class CreateCoursefiles < ActiveRecord::Migration
  def change
    create_table :coursefiles do |t|
      t.integer :course_id
      t.string :description
      t.string :name

      t.timestamps
    end
  end
end
