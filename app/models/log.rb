# == Schema Information
#
# Table name: logs
#
#  id            :integer          not null, primary key
#  date          :date             not null
#  end_at        :datetime
#  start_at      :datetime         not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  daily_note_id :integer          not null
#  user_id       :integer          not null
#
# Indexes
#
#  index_logs_on_daily_note_id  (daily_note_id)
#  index_logs_on_user_id        (user_id)
#
# Foreign Keys
#
#  daily_note_id  (daily_note_id => daily_notes.id)
#  user_id        (user_id => users.id)
#
class Log < ApplicationRecord
  validates :end_at, comparison: { greater_than: :start_at, allow_nil: true }

  belongs_to :user, foreign_key: 'user_id'
  belongs_to :daily_note, foreign_key: 'daily_note_id'

  def end_already?
    !end_at.nil?
  end

  def self.calc_sum_time(user:, date:)
    diff = 0
    user.logs.where(date:).each do |log|
      diff += (log.end_at - log.start_at) unless log.end_at.nil?
    end
    hours = (diff / 3600).to_i
    minutes = ((diff % 3600) / 60).to_i
    { hours:, minutes:, raw: diff }
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[date]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user]
  end
end
