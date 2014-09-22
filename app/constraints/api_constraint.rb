class ApiConstraint
  attr_reader :version

  def initialize(options)
    @version = options.fetch(:version,1)
  end

  def matches?(request)
    request
      .headers
      .fetch(:accept)
      .include?(".v#{version}")
  end
end
