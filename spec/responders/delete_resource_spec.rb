require 'rails_helper'

describe DeleteResource do
  describe '::delete' do
    let(:widget) {FactoryGirl.create(:widget)}

    it "destroys the resource" do
      expect(Widget).to receive(:find).and_return(widget)
      expect(widget).to receive(:destroy)
      DeleteResource.delete(Widget, widget.id, :find, :destroy)
    end

    it "raises ResourceNotFound if unable to find" do
      expect {DeleteResource.delete(Widget, widget.id, :find_and_raise )}.to raise_error(ResourceNotFound)
    end

    it "requires an id" do
      expect(DeleteResource.delete(Widget, nil).valid?).to eq(false)
    end
  end
end
