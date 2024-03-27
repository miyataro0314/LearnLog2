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
FactoryBot.define do
  factory :daily_note do
    content { 'example content' }
    sequence(:date) { |n| Date.today + n }
    mood { 1 }
    quote { 'example quote' }
    today_goal { '8' }
  end
end
