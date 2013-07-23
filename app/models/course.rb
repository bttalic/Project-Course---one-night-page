class Course < ActiveRecord::Base
	attr_accessible :name, :description, :coursecode, :lock, :code

	belongs_to :user
	 has_many :notifications, dependent: :destroy
	 has_many :coursefiles, dependent: :destroy
	validates :user_id, presence: true
	validates :name, presence: true, length: { maximum: 50 },
	uniqueness: { case_sensitive: false } 


	validates :description, presence: true, length: { maximum: 600 } 
	validates :coursecode, presence: true, length: { maximum: 6, minimum: 5 } 


	has_many :reverse_relationships, foreign_key: "listened_id",
	class_name:  "Relationship",
	dependent:   :destroy
	has_many :listeners, through: :reverse_relationships, source: :listener

	default_scope order: 'courses.name ASC'

	
end
