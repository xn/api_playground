class IndexResource
  include ActiveModel::Model
  attr_accessor :resource

  def self.index(resource,params,finder=:where)
    resource.send(finder,params).all
  end
end
