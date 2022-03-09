class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, format: {with: URI::MailTo::EMAIL_REGEXP}, uniqueness: true
  validates :password, presence: true, confirmation: true, length: {minimum: 4}

  before_save :add_uid

  def add_uid
    self.uid = uid_numbering
  end

  private
  def uid_numbering
    max_digit = 8
    max_number = 9
    uid_number = ''
    loop do
      uid_number = max_digit.times.map { rand(max_number) }.join
      result = User.find_by(uid: uid_number)
      if result.nil?
        break
      end
    end
    uid_number
  end
end
