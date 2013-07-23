class Relationship < ActiveRecord::Base
  attr_accessible :listened_id, :secretcode

  belongs_to :listener, class_name: "User"
  belongs_to :listened, class_name: "Course"

  validates :listener_id, presence: true
  validates :listened_id, presence: true
end
