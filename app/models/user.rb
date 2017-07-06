class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable

  has_many :ideas

  validates :email, :encrypted_password, presence: true

  def number_of_ideas_created_today
    return 0 unless ideas.any?
    ideas.ideas_created_today.count
  end

  def number_of_total_ideas
    return 0 unless ideas.any?
    ideas.count
  end
end
