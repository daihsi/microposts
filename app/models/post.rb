class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :content, presence: true, length: {maximum: 300}

  before_create :add_pid

  scope :post_all, ->{all}
  scope :include_user, -> {includes(:user)}
  scope :include_user_comments, -> {includes(:user, :comments)}
  scope :order_id_desc, -> {order(id: :desc)}
  scope :order_id_asc, -> {order(id: :asc)}

  def posts_sort(sort:)
    case sort
    when 'new_post'
      Post.include_user_comments.order_id_desc
    when 'old_post'
      Post.include_user_comments.order_id_asc
    when 'many_comment'
      Post.include_user_comments.find(Comment.group_post_id.post_id_count_desc.array_post_id)
    when 'many_like'
      Post.include_user_comments.order_id_desc
    else
      Post.include_user_comments.order_id_desc
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
