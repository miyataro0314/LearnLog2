# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  crypted_password :string           not null
#  email            :string           not null
#  name             :string           not null
#  salt             :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  authenticates_with_sorcery!
  has_one :profile, dependent: :destroy
  has_many :logs, dependent: :destroy
  has_many :daily_notes, dependent: :destroy
  has_many :mantras, dependent: :destroy

  validates :email, uniqueness: true
  validates :email, presence: true
  validates :name, presence: true, length: { maximum: 255 }

  validates :password, length: { minimum: 4, maximum: 12 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
end
