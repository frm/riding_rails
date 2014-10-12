class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  EMAIL_REGEX = /\A[\w\-.]+@[a-z\-\d]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :email, :name, :username, presence: true, length: {maximum: 50}
  validates :email, format: EMAIL_REGEX, uniqueness: {case_sensitive: false}
  validates :username, uniqueness: {case_sensitive: false}

  has_many :relationships, foreign_key: 'follower_id', :dependent => :destroy
  has_many :reverse_relationships, foreign_key: 'followed_id',
                                   class_name: 'Relationship',
                                   :dependent => :destroy

  has_many :microposts, dependent: :destroy

  def follow!(user)
    relationships.create(followed_id: user.id)
  end

  def unfollow!(user)
    relationship(user).destroy if following?(user)
  end

  def following?(user)
    !relationship(user).nil?
  end

  def followed_by?(user)
    !reverse_relationships.find_by(follower_id: user.id).nil?
  end

  def feed
    Micropost.where("user_id IN (?) OR user_id = ?", self.following_ids, self.id)
  end
end
