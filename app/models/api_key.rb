# == Schema Information
#
# Table name: api_keys
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  access_token :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_api_keys_on_access_token  (access_token) UNIQUE
#  index_api_keys_on_user_id       (user_id)
#

class ApiKey < ActiveRecord::Base
  before_create :generate_access_token
  belongs_to :user

  private

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
end
