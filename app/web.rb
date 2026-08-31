require 'sinatra'
require 'mongo'
require 'json'

include Mongo

class Web < Sinatra::Base
  configure do
    # Accept the connection string under any of the common env var names
    mongo_uri = ENV['MONGODB_URI'] || ENV['MONGO_URI'] || ENV['MONGO_URL'] ||
                ENV['MONGOLAB_URI'] || ENV['MONGOHQ_URL']

    if mongo_uri.nil? || mongo_uri.empty?
      raise 'MongoDB connection string not found. Please set MONGODB_URI ' \
            '(or MONGO_URI, MONGO_URL, MONGOLAB_URI, MONGOHQ_URL).'
    end

    # Let the driver parse the URI (including the database name); only pass
    # credentials if they are supplied out of band via env vars
    options = {}
    options[:user] = ENV['MONGODB_USER'] if ENV['MONGODB_USER']
    options[:password] = ENV['MONGODB_PASS'] if ENV['MONGODB_PASS']

    client = Mongo::Client.new(mongo_uri, options)
    # Allow the database to be overridden explicitly
    client = client.use(ENV['MONGO_DATABASE']) if ENV['MONGO_DATABASE']
    db = client.database

    set :root, File.dirname(__FILE__)
    set :public_folder, './public'

    set :mongo_client, client
    set :mongo_db, db
    set :poetry_coll, db.collection("poetry")

    # Sinatra 4 / rack-protection 4 enforce Host authorization: any request whose
    # Host is not allow-listed returns 403. Permit the hosts the API is served
    # under. NOTE: add any new domain here, or requests to it will be rejected.
    set :host_authorization, permitted_hosts: [
      'poetrydb.org', '.poetrydb.org',   # custom domain (apex) + any subdomain
      '.herokuapp.com',                  # Heroku app domain (poetrydb.herokuapp.com)
      'localhost', '127.0.0.1',          # local development
      'poetrydb'                         # docker-compose service name (local test harness)
    ]
  end

  def json_status(code, reason)
    status code
    {
      :status => code,
      :reason => reason
    }.to_json
  end

  after do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  get '/' do
    redirect '/index.html'
  end
end

require_relative 'helpers/init'
require_relative 'routes/init'
