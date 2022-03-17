module RelationshipsHelper
  def follow_or_unfollow_button(target_user:)
    button = ''
    if current_user.id != target_user.id
      if current_user.following?(user: target_user)
        button = button_to 'フォロー外す', relationships_create_path(target_user.id), method: :delete, class: 'btn btn-sm btn-danger'
      else
        button = button_to 'フォローする', relationships_destroy_path(target_user.id), method: :POST, class:'btn btn-sm btn-success'
      end
    end
    raw button
  end
end
