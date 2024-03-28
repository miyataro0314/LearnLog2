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
  before_validation :set_default_values

  belongs_to :user, foreign_key: 'user_id'
  belongs_to :daily_note, foreign_key: 'daily_note_id'

  validates :start_at, presence: true
  validates :end_at, comparison: { greater_than: :start_at, allow_nil: true }

  scope :today, ->(user) { where(user_id: user.id, date: Date.today) }
  scope :recorded_dates, ->(user) { where(user_id: user.id).select(:date).distinct }

  def end_already?
    !end_at.nil?
  end

  def self.sum_time(user, date)
    diff = 0
    user.logs.where(date:).each do |log|
      diff += (log.end_at - log.start_at) unless log.end_at.nil?
    end
    hours = (diff / 3600).to_i
    minutes = ((diff % 3600) / 60).to_i
    { hours:, minutes:, raw: diff }
  end

  def self.daily_average(user)
    days_count = Log.recorded_dates(user).count
    all_sum_time = Log.sum_time(user, Log.recorded_dates(user))
    raw = all_sum_time[:raw] / days_count
    hours = (raw / 3600).to_i
    minutes = ((raw % 3600) / 60).to_i
    { hours:, minutes:, raw: }
  end

  def self.ransackable_attributes(_auth_object = nil)
    %w[date]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[user]
  end

  private

  def set_default_values
    self.date ||= Date.today
    self.start_at ||= Time.current
  end
end
