require 'rails_helper'

describe PostResource do
  describe '::post' do
    let(:widget) {FactoryGirl.build(:widget)}
    it "Creates the resource" do
      expect(Widget).to receive(:create)
      PostResource.post(Widget, widget.attributes )
    end
  end
end
