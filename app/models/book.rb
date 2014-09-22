# == Schema Information
#
# Table name: books
#
#  id          :integer          not null, primary key
#  author_id   :integer
#  title       :string(255)
#  blurb       :string(255)
#  description :string(255)
#  admin_notes :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_books_on_author_id  (author_id)
#

class Book < ActiveRecord::Base
  belongs_to :author

  validates :author_id, presence: true
  scope :active, -> { where(active: true) }
end
