class PodioController < ApplicationController
  def index
    podio_service = PodioService.new
    @organizations = podio_service.list_organizations

    render json: @organizations.map { |org| { name: org.name, url: org.url } }
  end
end