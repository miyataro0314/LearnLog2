# == Schema Information
#
# Table name: mantras
#
#  id         :integer          not null, primary key
#  author     :string
#  body       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_mantras_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Mantra < ApplicationRecord
  belongs_to :user

  validates :body, presence: true
end
