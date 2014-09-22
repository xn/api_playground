class GetResource
  include ActiveModel::Model
  attr_accessor :id
  validates_presence_of :id

  def self.get(resource,id,finder=:find)
    getter = new(id: id)
    getter.valid? ? resource.send(finder,getter.id) : getter
  rescue
    raise ::ResourceNotFound
  end
end
