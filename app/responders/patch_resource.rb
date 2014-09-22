class PatchResource
  include ActiveModel::Model
  attr_accessor :id
  validates_presence_of :id

  def self.patch(resource,id,values,finder=:find,updater=:update)
    getter = new(id: id)
    getter.valid? ? patch_resource!(resource,getter.id,values,finder,updater) : getter
  rescue => e
    raise ::ResourceNotFound
  end

private
  def self.patch_resource!(resource,id,values,finder=:find,updater=:update)
    instance = resource.send(finder, id)
    instance.send(updater, values)
    instance
  end

end
