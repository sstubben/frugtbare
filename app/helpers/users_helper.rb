# frozen_string_literal: true

module UsersHelper
  def avatar_url(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=128"
  end

  def check_twitter_connection
    if current_user.connected_with_twitter
      link_to cancel_user_registration_path, class: 'btn btn-warning btn-sm' do
        content_tag :span, 'Disconnect Twitter', class: 'verified'
      end
    else
      link_to user_twitter_omniauth_authorize_path, class: 'btn btn-success btn-sm' do
        content_tag :span, 'Connect to Twitter', class: 'un-verified'
      end
    end
  end
end
