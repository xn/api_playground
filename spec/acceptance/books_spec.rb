require 'acceptance_helper'

resource "Books" do
  header "Accept", "application/vnd.libraryapi.v1+json"
  header "Content-Type", "application/json"
  let(:author) { FactoryGirl.create(:author) }
  let(:user) { author.user }
  let(:other_author) { FactoryGirl.create(:author) }

  before do
    FactoryGirl.create(:book, author: author)
    FactoryGirl.create(:book, author: other_author)
  end

  get '/books' do
    parameter :access_token, "Authorization Token"

    let(:access_token) { user.access_token }

    let(:raw_post) { params.to_json }

    example_request "Getting a list of books" do
      expect(response_body).to eq(ActiveModel::ArraySerializer.new(author.books, each_serializer: PublicBookSerializer).to_json)
      expect(status).to eq(200)
    end

  end

  head '/books' do
    parameter :access_token, "Authorization Token"

    let(:access_token) { user.access_token }

    let(:raw_post) { params.to_json }
    example_request "Getting the headers" do
      expect(response_headers["Cache-Control"]).to eq("max-age=0, private, must-revalidate")
    end
  end

  post '/books' do
    let(:book_attributes) { FactoryGirl.build(:book) }
    parameter :access_token, "Authorization Token"
    parameter :title, "Title", scope: :book
    parameter :description, "Description", scope: :book
    parameter :blurb, "Excerpt of Text", scope: :book

    response_field :id, "Id", scope: :book
    response_field :title, "Title", scope: :book
    response_field :description, "Description", scope: :book
    response_field :blurb, "Excerpt of Text", scope: :book

    let(:access_token) { user.access_token }
    let(:title) { book_attributes.title }
    let(:description) { book_attributes.description }
    let(:blurb) { book_attributes.blurb }

    let(:raw_post) { params.to_json }

    example_request "Creating a book" do
      explanation "First, create a book, then make a later request to get it back"

      book_hash = JSON.parse(response_body)
      expect(status).to eq(201)

      client.get("/books/#{ book_hash['book']['id'] }", { access_token: access_token }, headers)
      expect(status).to eq(200)
    end
  end

  get '/books/:id' do
    parameter :access_token, "Authorization Token"
    parameter :id, "Id", required: true

    response_field :id, "Id", scope: :book
    response_field :title, "Title", scope: :book
    response_field :description, "Description", scope: :book
    response_field :blurb, "Excerpt of Text", scope: :book

    let(:book) { author.books.first }
    let(:id) { book.id }
    let(:access_token) { user.access_token }

    let(:raw_post) { params.to_json }

    example_request "Getting a specific book" do
      book_hash = JSON.parse(response_body)
      expect(book_hash.to_json).to eq(PublicBookSerializer.new(book).to_json)
      expect(status).to eq(200)
    end
  end

  put '/books/:id' do
    let(:book_attributes) { FactoryGirl.build(:book, title: "New Title") }

    parameter :id, "Id", required: true
    parameter :access_token, "Authorization Token"
    parameter :title, "Title", scope: :book
    parameter :description, "Description", scope: :book
    parameter :blurb, "Excerpt of Text", scope: :book

    response_field :id, "Id", scope: :book
    response_field :title, "Title", scope: :book
    response_field :description, "Description", scope: :book
    response_field :blurb, "Excerpt of Text", scope: :book

    let(:book) { author.books.first }
    let(:id) { book.id }
    let(:access_token) { user.access_token }
    let(:title) { book_attributes.title }
    let(:description) { book_attributes.description }
    let(:blurb) { book_attributes.blurb }


    let(:raw_post) { params.to_json }

    example_request "Updating a book title" do
      expect(status).to eq(204)
    end
  end

  delete '/books/:id' do
    parameter :access_token, "Authorization Token"
    let(:access_token) { user.access_token }
    let(:book) { author.books.first }
    let(:id) { book.id }

    let(:raw_post) { params.to_json }

    example_request "Deleting a book" do
      expect(status).to eq(204)
    end
  end
end
