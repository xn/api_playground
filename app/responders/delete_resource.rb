class DeleteResource
  include ActiveModel::Model
  attr_accessor :id
  validates_presence_of :id

  def self.delete(resource,id,finder=:find,deleter=:destroy)
    getter = new(id: id)
    getter.valid? ? resource.send(finder,getter.id).send(deleter) : getter
  rescue
    raise ::ResourceNotFound
  end
end
