# == Schema Information
#
# Table name: daily_notes
#
#  id         :integer          not null, primary key
#  content    :text
#  date       :date             not null
#  mood       :integer
#  quote      :string
#  today_goal :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_daily_notes_on_date              (date)
#  index_daily_notes_on_user_id           (user_id)
#  index_daily_notes_on_user_id_and_date  (user_id,date) UNIQUE
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class DailyNote < ApplicationRecord
  enum mood: { Poor: 1, Fair: 2, Average: 3, Good: 4, Excellent: 5 }, _prefix: true

  has_many :logs
  belongs_to :user, foreign_key: 'user_id'

  validates :date, presence: true
  validates :date, uniqueness: true
  validates :today_goal, presence: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[date]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user]
  end
end
