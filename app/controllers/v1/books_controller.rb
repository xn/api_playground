class V1::BooksController < V1::BaseController
  before_action :ensure_authorized
  respond_to :json_v1

  def index
    emit_to_client(ResourceResponder.index(BookRetrievalService.resource_for(current_user), params.fetch(:q, {})), index_serializer, book_serializer)
  end

  def show
    emit_to_client(ResourceResponder.get(BookRetrievalService.resource_for(current_user), book_id), book_serializer)
  end

  def create
    emit_to_client(ResourceResponder.post(BookPersistenceService.resource_for(current_user), book_params), book_serializer)
  end

  def update
    emit_to_client(ResourceResponder.patch(BookRetrievalService.resource_for(current_user), book_id, book_params), book_serializer)
  end

  def destroy
    emit_to_client(ResourceResponder.delete(BookRetrievalService.resource_for(current_user), book_id), book_serializer)
  end

  private

  def ensure_authorized
    raise ::NotAuthorized unless %w(Admin Author).include? current_user.capacity_type
  end

  def book_id
    params.require(:id)
  end

  def book_params
    params.require(:book).permit(:id, :title, :blurb, :description, :admin_notes )
  end

  def book_serializer
    case current_user.capacity_type
    when "Author"
      PublicBookSerializer
    when "Admin"
      PrivateBookSerializer
    else
      raise "Unknown capacity"
    end
  end
end
