include Warden::Test::Helpers

module IntegrationMacros
  def create_user!
    @user = users :user
  end

  def login_with_warden(user = users(:user))
    login_as(user)
  end

  def logout_with_warden!
    logout(:user)
  end
end
