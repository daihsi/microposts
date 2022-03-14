class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true, length: {maximum: 300}

  scope :include_user, -> {includes(:user)}
  scope :id_desc, -> {order(id: :desc)}
  scope :post_id_count_desc, -> {order('count(post_id) desc')}
  scope :group_post_id, -> {group(:post_id)}
  scope :array_post_id, -> {pluck(:post_id)}

  def set_user_id(login_user_id:)
    self.user_id = login_user_id
  end

  def set_post_id(pid:)
    self.post_id = Post.find_by(pid: pid).id
  end

end
