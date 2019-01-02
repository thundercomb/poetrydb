require 'sinatra'
require 'mongo'
require 'json'

include Mongo

class Web < Sinatra::Base
  configure do
    mongo_uri = ENV['MONGOLAB_URI']
    db_name = mongo_uri[%r{/([^/\?]+)(\?|$)}, 1]
    client = MongoClient.from_uri(mongo_uri)
    db = client.db(db_name)

    set :root, File.dirname(__FILE__)
    set :public_folder, './public'
  
    set :mongo_client, client
    set :mongo_db, db
    set :poetry_coll, db.collection("poetry")
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
