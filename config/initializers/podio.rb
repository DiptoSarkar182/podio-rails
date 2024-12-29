require 'podio'
puts "PODIO_API_KEY: #{ENV['PODIO_API_KEY']}"
puts "PODIO_API_SECRET: #{ENV['PODIO_API_SECRET']}"

Podio.setup(api_key: ENV["PODIO_API_KEY"], api_secret: ENV["PODIO_API_SECRET"])
puts "Podio.client initialized: #{Podio.client.inspect}"