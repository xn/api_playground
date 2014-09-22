# == Schema Information
#
# Table name: authors
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Author < ActiveRecord::Base
  has_many :books
  has_one :user, as: :capacity
end
