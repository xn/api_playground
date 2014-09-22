class V1::BaseController < ApplicationController
  include Apiable
  before_action :ensure_authenticated
  rescue_from ::ResourceNotFound, with: :resource_not_found
  rescue_from ::NotAuthorized, with: :not_authorized

  private

  def auth_params
    params.permit(:access_token)
  end

  def finalize_response(renderable,status)
    respond_to do |format|
      format.json_v1 { render json: renderable.to_json, status: status }
    end
  end

end
