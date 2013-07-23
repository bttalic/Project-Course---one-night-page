class AddAttachmentFileToCoursefiles < ActiveRecord::Migration
  def self.up
    change_table :coursefiles do |t|
      t.attachment :file
    end
  end

  def self.down
    drop_attached_file :coursefiles, :file
  end
end
