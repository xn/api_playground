class PostResource
  def self.post(resource,values)
    resource.create(values)
  end
end
