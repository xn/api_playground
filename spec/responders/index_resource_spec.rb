require 'rails_helper'

describe IndexResource do
  describe '::index' do
    let(:widget) {FactoryGirl.create(:widget)}
    it "gets a list of resources" do
      expect(Widget).to receive(:where).and_return(Map.new(all: []))
      IndexResource.index(Widget, {}, :where)
    end
  end
end
