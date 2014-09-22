require 'rails_helper'

describe ResourceNotFound do
  it 'inherits from StandardError' do
    expect(ResourceNotFound.ancestors.any?{|a| a == StandardError}).to eq(true)
  end
end
