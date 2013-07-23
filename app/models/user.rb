class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :officehours
  has_secure_password
  has_many :relationships, foreign_key: "listener_id", dependent: :destroy
  has_many :listened_courses, through: :relationships, source: :listened
 # has_many :reverse_relationships, foreign_key: "listened_id",
  #                                 class_name:  "Relationship",
  #                                 dependent:   :destroy
  #has_many :listeners, through: :reverse_relationships, source: :listener
  has_many :courses
  before_save { email.downcase! }
  before_save :create_remember_token

  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, :on => :create
  validates :password_confirmation, presence: true, :on => :create

  attr_accessible :avatar
  has_attached_file :avatar, dependent: :destroy

  def feed
    getFeed
  end
  def feed2
    getFeed2
  end

  def getFeed
    listened=Relationship.find_all_by_listener_id(self.id)
    allid=Array.new
    listened.each do |rel|
      allid.push(rel.listened_id)
    end
    return Notification.find_all_by_course_id(allid)
end

 def getFeed2
    listened=Relationship.find_all_by_listener_id(self.id)
    allid=Array.new
    listened.each do |rel|
      allid.push(rel.listened_id)
    end
    return Coursefile.find_all_by_course_id(allid)
end


  def listening?(course)
    relationships.find_by_listened_id(course.id)
  end

  def listen!(course)
    relationships.create!(listened_id: course.id)
  end

  def unlisten!(course)
    relationships.find_by_listened_id(course.id).destroy
  end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
end
