# == Schema Information
#
# Table name: profiles
#
#  id            :integer          not null, primary key
#  avatar        :string
#  mantra_config :integer
#  week_goal     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  user_id       :integer          not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Profile < ApplicationRecord
  enum mantra_config: { disabled: 0, style1: 1, style2: 2 }
  belongs_to :user

  mount_uploader :avatar, AvatarUploader
end
