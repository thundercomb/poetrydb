require 'sinatra'

class Web < Sinatra::Base

  get '/author/:author/all.?:format?' do
    content_type :json
    format = params[:format]

    @data = find_data(params[:author], 'author')
    respond @data, format
  end

  get '/author/:author/:fields' do
    content_type :json
    # Split on '.' for possible format suffix
    output_fields = params[:fields].split('.')[0].split(',')
    format = params[:fields].split('.')[1]

    @data = find_data(params[:author], 'author', output_fields)
    respond @data, format
  end 

  get '/author/:author' do
    content_type :json

    @data = find_data(params[:author], 'author')
    respond @data
  end
end
