class User < ApplicationRecord
  has_secure_password

  has_many :posts

  validates :name, presence: true
  validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP}, uniqueness: true
  validates :password, presence: true, confirmation: true, length: {minimum: 4}

  before_create :add_uid

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
