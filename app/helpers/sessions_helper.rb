module SessionsHelper
  def log_out_button
    html = ''
    unless current_user.nil?
      html = button_to 'ログアウト', logout_path,  method: :delete, class: 'btn btn-outline-secondary'
    end
    raw html
  end
end
