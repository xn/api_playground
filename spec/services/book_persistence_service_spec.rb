require 'rails_helper'

describe BookPersistenceService do
  let(:author_user) { FactoryGirl.create(:author).user }
  let(:admin_user) { FactoryGirl.create(:admin).user }

  describe '::resource_for' do
    it 'returns a BookPersistenceService instance' do
      book_persister = BookPersistenceService.resource_for(author_user)
      expect(book_persister.is_a?(BookPersistenceService)).to eq(true)
    end
  end

  describe '#create' do
    context 'Author' do
      it 'it assigns the author to the requestor' do
        book_persister = BookPersistenceService.resource_for(author_user)
        expect(book_persister.create.author_id).to eq(author_user.capacity_id)
      end
    end

    context 'Admin' do
      it 'it allows the admin to set the author_id' do
        book_persister = BookPersistenceService.resource_for(admin_user)
        author_id = admin_user.id + 1
        expect(book_persister.create(author_id: author_id).author_id).to eq(author_id)
      end
    end

    context 'valid' do
      it 'processes text' do
        book_persister = BookPersistenceService.resource_for(admin_user)
        expect(book_persister).to receive(:process_text!)
        book = book_persister.create(author_id: 1)
      end

      it 'sends notifications' do
        book_persister = BookPersistenceService.resource_for(admin_user)
        expect(book_persister).to receive(:notify!)
        book = book_persister.create(author_id: 1)
      end
    end

    context 'invalid' do
      it 'does not process text' do
        book_persister = BookPersistenceService.resource_for(admin_user)
        expect(book_persister).to_not receive(:process_text!)
        book = book_persister.create()
      end

      it 'does not send notifications' do
        book_persister = BookPersistenceService.resource_for(admin_user)
        expect(book_persister).to_not receive(:notify!)
        book = book_persister.create()
      end
    end
  end

  describe '#valid?' do
    it 'validates the created resource' do
      book_persister = BookPersistenceService.resource_for(admin_user)
      book = book_persister.create(author_id: 1)
      expect(book_persister.valid?).to eq(book.valid?)
    end
  end
end
