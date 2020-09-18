require 'mongo'
require 'json'
require 'bson'

include Mongo

json_inputfile = ARGV[0]
mongo_uri = ENV['MONGODB_URI']
username = ENV['USER']
password = ENV['PASS']

db_name = mongo_uri[%r{/([^/\?]+)(\?|$)}, 1]
client = Mongo::Client.new(mongo_uri, :database => db_name, :user => username, :password => password)
db = client.database

coll = db.collection("poetry")
coll.delete_many({})

@data = JSON.parse(IO.read("#{json_inputfile}"))

@data['poem'].each do |poem|
  #coll.insert(poem)
  coll.insert_one(poem)
end
