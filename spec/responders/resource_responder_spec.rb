require 'rails_helper'

describe ResourceResponder do
  let(:widget) {FactoryGirl.create(:widget)}
  let(:some_resource){ double("FakeResource")}
  describe '::index' do
    it "lists the resource" do
      expect(some_resource).to receive(:index)
      ResourceResponder.index(Widget, {some_id: 3}, some_resource)
    end
  end

  describe '::get' do
    it "gets the resource" do
      expect(some_resource).to receive(:get)
      ResourceResponder.get(Widget, widget.id, some_resource)
    end
  end

  describe '::post' do
    let(:widget_attributes) {FactoryGirl.build(:widget).attributes}
    it "posts the resource" do
      expect(some_resource).to receive(:post)
      ResourceResponder.post(Widget, widget_attributes, some_resource)
    end
  end

  describe '::patch' do
    it "patches the resource" do
      expect(some_resource).to receive(:patch)
      ResourceResponder.patch(Widget, widget.id, {some_id: 3}, some_resource)
    end
  end

  describe '::delete' do
    it "deletes the resource" do
      expect(some_resource).to receive(:delete)
      ResourceResponder.delete(Widget, widget.id, some_resource)
    end
  end
end
