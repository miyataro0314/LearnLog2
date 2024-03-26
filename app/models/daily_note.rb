class DailyNote < ApplicationRecord
  enum mood: { Poor: 1, Fair: 2, Average: 3, Good: 4, Excellent: 5 }, _prefix: true

  has_many :logs
  belongs_to :user, foreign_key: 'user_id'

  validates :today_goal, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[date]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user]
  end
end
