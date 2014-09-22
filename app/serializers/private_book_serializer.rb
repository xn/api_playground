class PrivateBookSerializer < ActiveModel::Serializer
  attributes :id, :title, :blurb, :description, :admin_notes
  has_one :author

  self.root = "book"
end
