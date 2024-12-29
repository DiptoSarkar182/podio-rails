class PodioController < ApplicationController
  def list_organizations
    podio_service = PodioService.new(:credentials)
    organizations = podio_service.list_organizations

    render json: {
      status: 200,
      message: "Organizations fetched successfully",
      data: organizations.map { |org| format_organization(org) }
    }
  end

  def app_items
    podio_service = PodioService.new(:app)
    app_id = params[:app_id]
    items = podio_service.list_app_items(app_id)

    render json: {
      status: 200,
      message: "App items fetched successfully",
      data: items.map { |item| format_item(item) }
    }
  end

  def item_details
    podio_service = PodioService.new(:app)
    item_id = params[:item_id]
    item = podio_service.fetch_item_details(item_id)

    render json: {
      status: 200,
      message: "Item details fetched successfully",
      data: format_item(item)
    }
  end

  def app_definition
    podio_service = PodioService.new(:app)
    app_id = params[:app_id]
    app_definition = podio_service.fetch_app_definition(app_id)

    if app_definition
      render json: {
        status: 200,
        message: "App definition fetched successfully",
        data: app_definition
      }
    else
      render json: {
        status: 422,
        message: "Unable to fetch app definition",
        error: "App definition not found"
      }, status: :unprocessable_entity
    end
  end

  private

  def format_item(item)
    {
      id: item["item_id"],
      title: item["title"],
      fields: item["fields"]&.map { |field| { label: field["label"], value: field["values"] } }
    }
  end

  def format_organization(org)
    {
      id: org["org_id"],
      name: org["name"],
      spaces: org["spaces"]&.map { |space| { id: space["space_id"], name: space["name"] } }
    }
  end
end
