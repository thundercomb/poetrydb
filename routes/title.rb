require 'sinatra'

class Web < Sinatra::Base

  get '/title?s?' do
    content_type :json

    @data = find_list('title')
    respond @data
  end

  get '/title/:title/all.?:format?' do
    content_type :json
    format = params[:format]

    @data = find_data(params[:title], 'title')
    respond @data, format
  end

  get '/title/:title/:fields' do
    content_type :json
    # Split on '.' for possible format suffix
    output_fields = params[:fields].split('.')[0].split(',')
    format = params[:fields].split('.')[1]

    @data = find_data(params[:title], 'title', output_fields)
    respond @data, format
  end

  get '/title/:title' do
    content_type :json
  
    @data = find_data(params[:title], 'title')
    respond @data
  end
end
