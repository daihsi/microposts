class User < ApplicationRecord
  has_secure_password

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :follower, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy
  has_many :followed, class_name: 'Relationship', foreign_key: 'followed_id', dependent: :destroy
  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: :post

  validates :name, presence: true
  validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP}, uniqueness: true
  validates :password, presence: true, confirmation: true, length: {minimum: 4}

  scope :id_desc, -> {order(id: :desc)}

  before_create :add_uid

  def follow(user_id:)
    follower.create(followed_id: user_id)
  end

  def unfollow(user_id:)
    follower.find_by(followed_id: user_id).destroy
  end

  def following?(user:)
    following_user.include?(user)
  end

  def like_post(post_id:)
    likes.create(post_id)
  end

  def unlike_post(post_id:)
    likes.find_by(post_id: post_id).destroy
  end

  def like_post?(post:)
    like_posts.include?(post)
  end

  private
  def add_uid
    uid = ''
    loop do
      uid = id_numbering
      result = User.find_by(uid: uid)
      if result.nil?
        break
      end
    end
    self.uid = uid
  end

end
