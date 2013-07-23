class Coursefile < ActiveRecord::Base
  attr_accessible :course_id, :description, :name, :file
   attr_accessible :file_file_name
  belongs_to :course
  has_attached_file :file

  
validates :file, presence: true
validates :name, presence: true, length: { maximum: 50 }
	
validates :description, presence: true, length: { maximum: 100 }
	
validates_attachment_content_type :file, 
	:content_type => /\/(doc|docx|zip|rar|pdf|ppt)/
 #default_scope order: 'coursfiles.created_at DESC'
	
end
