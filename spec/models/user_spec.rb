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
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'アソシエーションチェック' do
  end
  describe 'バリデーションチェック' do
    context ':email' do
      it '重複している時にエラーとなるか' do
        user1 = create(:user, email: 'duplicate@example.com')
        user2 = build(:user, email: 'duplicate@example.com')
        expect(user2).to be_invalid
      end
      it 'nilの時にエラーとなるか' do
        user = build(:user, email: nil)
        expect(user).to be_invalid
      end
    end

    context ':name' do
      it 'nilの時にエラーとなるか' do
        user = build(:user, name: nil)
        expect(user).to be_invalid
      end
    end

    context ':password' do
      it '3文字以下の時にエラーとなるか' do
        user = build(:user, password: 1, password_confirmation: 1)
        expect(user).to be_invalid
      end
      it '13文字以上の時にエラーとなるか' do
        user = build(:user, password: 1234567890123, password_confirmation: 1234567890123)
        expect(user).to be_invalid
      end
    end
  end
end
