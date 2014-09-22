require 'rails_helper'

describe PatchResource do
  describe '::patch' do
    let(:widget) {FactoryGirl.create(:widget)}

    it "updates the resource" do
      expect(Widget).to receive(:find).and_return(widget)
      expect(widget).to receive(:update)
      PatchResource.patch(Widget, widget.id, {}, :find, :update)
    end

    it "raises ResourceNotFound if unable to find" do
      expect {PatchResource.patch(Widget, widget.id, {}, :find_and_raise, :update )}.to raise_error(ResourceNotFound)
    end

    it "requires an id" do
      expect(PatchResource.patch(Widget, nil, {}, :find, :update).valid?).to eq(false)
    end
  end
end
