class Idea < ActiveRecord::Base
  belongs_to :user

  validates :description, presence: true

  validates :level_of_complexity, :level_of_fun, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5
  }

  scope :ideas_created_today, -> { where('DATE(created_at)=?', Time.zone.today) }

  def rating
    level_of_fun - level_of_complexity
  end
end
