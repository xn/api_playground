class BookPersistenceService
  attr_reader :resource, :params

  def self.resource_for(who)
    new(who)
  end

  def initialize(who)
    @resource = case who.capacity_type
    when "Author"
      who.capacity.books
    else
      Book
    end
    @who = who
  end

  def create(params={})
    params = secure_params!(params)
    @instance = resource.create(params)
    if valid?
      process_text!
      notify!
    end
    @instance
  end

  def valid?
    @instance.valid?
  end

  def invalid?
    !@instance.valid?
  end

  private

  def secure_params!(params)
    if @who.capacity_type == 'Author'
      params.delete(:author_id)
      params.delete(:admin_notes)
    end
    params
  end

  def process_text!
    #call to some out of band process
    true
  end

  def notify!
    #another call to an external service
    true
  end

end
