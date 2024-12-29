class PodioService
  def initialize
    authenticate
  end

  def authenticate
    unless Podio.client
      puts "Reinitializing Podio client..."
      Podio.setup(api_key: ENV["PODIO_API_KEY"], api_secret: ENV["PODIO_API_SECRET"])
    end

    puts "Authenticating Podio client..."
    Podio.client.authenticate_with_credentials(ENV['PODIO_USERNAME'], ENV['PODIO_PASSWORD'])
    puts "Authentication successful"
  end

  def list_organizations
    Podio::Organization.find_all
  end
end
