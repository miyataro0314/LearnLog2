class Log < ApplicationRecord
  validates :end_at, comparison: { greater_than: :start_at, allow_nil: true }
  
  belongs_to :user, foreign_key: 'user_id'
  belongs_to :daily_note, foreign_key: 'daily_note_id'

  def end_already?
    !end_at.nil?
  end
  
  def self.calc_sum_time(user:, date:)
    diff = 0
    user.logs.where(date: date).each do |log|
      unless log.end_at.nil?
        diff += (log.end_at - log.start_at)
      end
    end
    hours = (diff / 3600).to_i
    minutes = ((diff % 3600) / 60).to_i
    return { hours: hours, minutes: minutes, raw: diff }
  end
  
  def self.ransackable_attributes(auth_object = nil)
    %w[date]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[user]
  end
end