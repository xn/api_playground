class PublicBookSerializer < ActiveModel::Serializer
  attributes :id, :title, :blurb, :description
  has_one :author

  self.root = "book"
end
