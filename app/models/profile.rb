class Profile < ApplicationRecord
  enum mantra_config: { disabled: 0, style1: 1, style2: 2 }
  belongs_to :user

  mount_uploader :avatar, AvatarUploader
end
