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

  def response_format(data, format, origin='header')
    # content negotiation based on http header
    if origin.eql? 'header'
      format.each do |format| 
        return JSON.pretty_generate(@data) if format.downcase.eql? 'application/json'
        return JSON.pretty_generate(@data) if format.downcase.eql? 'text/html'
      end
      # If format is empty default to json
      JSON.pretty_generate(@data)
    # Format determined by suffix in URL
    elsif origin.eql? 'suffix'
      case format
      when 'json'
        JSON.pretty_generate(@data)
      when 'text'
        s = ""; @data.each { 
          |poem| s.concat(poem.flatten.join("\n").concat("\n\n")) 
        }
        s
      end
    else
      JSON.pretty_generate(@data)
    end
  end

  def respond(data, format='json')
    if @data.length > 0
      @data.each { |poem| poem.delete('_id') }
      if format.nil?
        response_format @data, request.accept
      else
        response_format @data, format, 'suffix'
      end
    else
      json_status 404, "Not found"
    end
  end

  def find_data(search_term, field_type,
                output_fields = ['title','author','lines','linecount'])
    if search_term.class.eql? Fixnum
      settings.poetry_coll.find(
        {"#{field_type}" => search_term}, :fields => output_fields
      ).to_a
    elsif search_term[-4..-1].eql? ':abs'
      settings.poetry_coll.find(
        {"#{field_type}" => search_term[0..-5]}, :fields => output_fields
      ).to_a
    else
      settings.poetry_coll.find(
        {"#{field_type}" => /#{search_term}/}, :fields => output_fields
      ).to_a
    end
  end

  def json_status(code, reason)
    status code
    {
      :status => code,
      :reason => reason
    }.to_json
  end

  get '/' do
    redirect '/index.html'
  end
end

require_relative 'routes/init'
