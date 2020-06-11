require 'httparty'

class TestHttp
  include HTTParty
  base_uri "http://localhost:3000"
end
