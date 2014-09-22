module Apiable
  extend ActiveSupport::Concern

  private

  def current_user
    @current_user
  end

  def user_and_action
    Map.new(user: current_user, action: action_name.to_sym)
  end

  def resource_not_found
    emit_to_client(Map.new(response: {errors: ["not found"]}, status: 404),nil)
  end

  def emit_to_client(deliverable,serializer,each_serializer=nil)
    renderable = if deliverable.response.try(:errors).present?
      deliverable.response
    elsif each_serializer.present?
      serializer.new(deliverable.response, each_serializer: each_serializer, scope: user_and_action)
    else
      serializer.new(deliverable.response, scope: user_and_action)
    end

    finalize_response(renderable, deliverable.status)
  end

  def ensure_authenticated
    if restrict_access_by_params || restrict_access_by_header
      @current_user = @api_key.user if @api_key
    else
      invalid_credentials
    end
  end

  def invalid_credentials
    emit_to_client(Map.new(response: {errors: ["Invalid Credentials"]}, status: 400),nil)
  end

  def not_authorized
    emit_to_client(Map.new(response: {errors: ["Invalid Authorization"]}, status: 401),nil)
  end

  def restrict_access_by_header
    return true if @api_key

    authenticate_with_http_token do |token|
      @api_key = ApiKey.find_by_access_token(token)
    end
  end

  def restrict_access_by_params
    return true if @api_key
    @api_key = ApiKey.find_by_access_token(auth_params[:access_token])
  end

  def index_serializer
    ActiveModel::ArraySerializer
  end

  def finalize_response(renderable,status)
    raise "NOT IMPLEMENTED"
  end

end
