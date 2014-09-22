require 'rails_helper'

describe BookRetrievalService do
  let(:author) { FactoryGirl.create(:author) }
  let(:other_author) { FactoryGirl.create(:author) }

  before do
    FactoryGirl.create(:book, author: author)
    FactoryGirl.create(:book, author: other_author)
  end

  describe '::resource_for' do
    context 'Author' do
      it 'scopes by author id' do
        expect(BookRetrievalService.resource_for(author.user).all?{|b| b.author_id == author.id}).to be(true)
      end
    end

    context 'Admin' do
      let(:admin) { FactoryGirl.create(:admin) }

      it 'scopes by author id' do
        book_count = Book.count
        expect(BookRetrievalService.resource_for(admin.user).count).to eq(book_count)
      end
    end
  end
end
