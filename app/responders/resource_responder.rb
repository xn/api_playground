class ResourceResponder
  attr_reader :resource

  def self.index(resource,id,receiver=IndexResource)
    new(receiver.index(resource,id), :index)
  end

  def self.get(resource,id,receiver=GetResource)
    new(receiver.get(resource,id), :get)
  end

  def self.post(resource,params,receiver=PostResource)
    new(receiver.post(resource,params), :post)
  end

  def self.patch(resource,id,params,receiver=PatchResource)
    new(receiver.patch(resource,id,params), :patch)
  end

  def self.delete(resource,id,receiver=DeleteResource)
    new(receiver.delete(resource,id), :delete)
  end

  def initialize(resource, verb)
    @resource = resource
    @verb = verb.to_sym
  end

  def status
    success? ? success_codes[@verb] : error_codes[@verb]
  end

  def success?
    if resource.respond_to? :valid?
      resource.valid?
    else
      true
    end
  end

  def response
    @resource
  end

  def error_codes
    @error_codes ||= {
      get:    400,
      post:   400,
      patch:  400,
      put:    400,
      delete: 400,
      index:  400,
    }
  end

  def success_codes
    @success_codes ||= {
      get:    200,
      post:   201,
      patch:  204,
      put:    204,
      delete: 204,
      index:  200,
    }
  end
end
