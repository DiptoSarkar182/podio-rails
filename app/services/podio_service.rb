class PodioService
  def initialize(auth_method = :credentials)
    authenticate(auth_method)
  end

  def authenticate(auth_method)
    unless Podio.client
      Podio.setup(
        api_key: Rails.application.credentials.podio[:api_key],
        api_secret: Rails.application.credentials.podio[:api_secret]
      )
    end

    case auth_method
    when :credentials
      Podio.client.authenticate_with_credentials(
        Rails.application.credentials.podio[:username],
        Rails.application.credentials.podio[:password]
      )
    when :app
      Podio.client.authenticate_with_app(
        Rails.application.credentials.podio[:app_id],
        Rails.application.credentials.podio[:app_token]
      )
    else
      raise ArgumentError, "Unknown authentication method: #{auth_method}"
    end
  end

  def list_organizations
    Podio::Organization.find_all
  end

  def list_app_items(app_id)
    puts "Fetching items for app_id: #{app_id}"
    response = Podio::Item.find_all(app_id)
    puts "Response from Podio::Item.find_all: #{response.inspect}"
    response.all
  rescue Podio::PodioError => e
    puts "Error fetching app items: #{e.message}"
    []
  end

  def fetch_item_details(item_id)
    Podio::Item.find(item_id)
  end

  def fetch_app_definition(app_id)
    Podio::Application.find(app_id)
  rescue Podio::PodioError => e
    puts "Error fetching app definition: #{e.message}"
    nil
  end
end