class BookRetrievalService
    attr_reader :resource

  def self.resource_for(who)
    new(who).resource
  end

  def initialize(who)
    @resource = case who.capacity_type
    when "Author"
      who.capacity.books
    else
      Book
    end
  end
end
