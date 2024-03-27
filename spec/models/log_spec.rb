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
require 'rails_helper'

RSpec.describe Log, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
