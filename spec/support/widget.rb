class Widget
  include ActiveModel::Model
  attr_accessor :id, :some_other_id, :some_id

  def self.all
  end

  def self.create(params)
  end

  def self.where(params)
  end

  def self.update(params)
  end

  def self.destroy(params)
  end

  def self.find(id)
    Widget.new(id: id, some_other_id: id, some_id: id)
  end

  def self.find_and_raise(id)
    raise
  end

  def save!
  end

  def update(params)
  end

  def destroy
  end

  def attributes
    { id: id, some_other_id: some_other_id, some_id: some_id}
  end
end
