require 'httparty'

class TestHttp
  include HTTParty
  base_uri ENV.fetch("POETRYDB_BASE_URI", "http://localhost:3000")
end
