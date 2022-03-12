class Post < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: {maximum: 300}

  before_create :add_pid

  scope :post_all_with_user, -> {all.includes(:user)}
  scope :order_id_desc, -> {order(id: :desc)}
  scope :order_id_asc, -> {order(id: :asc)}

  def posts_sort(sort:)
    post_all_with_user = Post.post_all_with_user
    case sort
    when 'new_post'
      post_all_with_user.order_id_desc
    when 'old_post'
      post_all_with_user.order_id_asc
    when 'many_comment'
      post_all_with_user.order_id_desc
    when 'many_like'
      post_all_with_user.order_id_desc
    else
      post_all_with_user.order_id_desc
    end
  end

  private
  def add_pid
    pid = ''
    loop do
      pid = id_numbering
      result = Post.find_by(pid: pid)
      if result.nil?
        break
      end
    end
    self.pid = pid
  end

end
