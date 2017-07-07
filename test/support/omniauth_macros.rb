# frozen_string_literal: true

module OmniauthMacros
  def mock_auth_hash(user_email)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
      'provider' => 'twitter', 'uid' => '123545',
      'info' => {
        'name' => 'mockuser', 'image' => 'mock_user_thumbnail_url',
        'email' => user_email
      },
      'credentials' => { 'token' => 'mock_token', 'secret' => 'mock_secret' }
    )
  end
end
