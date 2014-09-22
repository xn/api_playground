# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  email            :string(255)      not null
#  crypted_password :string(255)      not null
#  salt             :string(255)      not null
#  capacity_id      :integer
#  capacity_type    :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#

class User < ActiveRecord::Base
  authenticates_with_sorcery!
  belongs_to :capacity, polymorphic: true
  has_one :api_key, dependent: :destroy

  delegate :access_token, to: :api_key

  after_create :create_api_key

  scope :from_access_token, lambda { |access_token|
    joins(:api_key).where(api_keys: {access_token: access_token})
  }

  def is_admin?
    capacity_type == 'Admin'
  end

  def create_api_key
    build_api_key.save
  end
end
