class Notification < ActiveRecord::Base
  attr_accessible :content, :course_id, :user_id
  belongs_to :course

  validates :content, presence: true, length: { maximum: 140 }

  default_scope order: 'notifications.created_at DESC'

  def self.from_users_listened_by(user)
    listened_user_ids = "SELECT listened_id FROM relationships
                         WHERE listener_id = :user_id"
    where("user_id IN (#{listened_user_ids}) OR user_id = :user_id", 
          user_id: user.id)
  end
end
