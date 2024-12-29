class PodioService
  def initialize
    authenticate
  end

  def authenticate
    unless Podio.client
      puts "Reinitializing Podio client..."
      Podio.setup(
        api_key: Rails.application.credentials.podio[:api_key],
        api_secret: Rails.application.credentials.podio[:api_secret]
      )
    end

    puts "Authenticating Podio client..."
    Podio.client.authenticate_with_credentials(
      Rails.application.credentials.podio[:username],
      Rails.application.credentials.podio[:password]
    )
    puts "Authentication successful"
  end

  def list_organizations
    Podio::Organization.find_all
  end
end
