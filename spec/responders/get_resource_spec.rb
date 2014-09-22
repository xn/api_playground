require 'rails_helper'

describe GetResource do
  describe '::get' do
    let(:widget) {FactoryGirl.create(:widget)}
    it "gets the resource" do
      expect(Widget).to receive(:find).and_return(widget)
      GetResource.get(Widget, widget.id )
    end

    it "raises ResourceNotFound if unable to find" do
      expect {GetResource.get(Widget, widget.id, :find_and_raise )}.to raise_error(ResourceNotFound)
    end

    it "requires an id" do
      expect(GetResource.get(Widget, nil).valid?).to eq(false)
    end
  end
end
