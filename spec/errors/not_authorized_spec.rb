require 'rails_helper'

describe NotAuthorized do
  it 'inherits from StandardError' do
    expect(NotAuthorized.ancestors.any?{|a| a == StandardError}).to eq(true)
  end
end
