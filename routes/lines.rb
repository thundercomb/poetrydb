require 'sinatra'

class Web < Sinatra::Base

  get '/lines/:lines/all.?:format?' do
    content_type :json
    format = params[:format]

    @data = find_data(params[:lines], 'lines')
    respond @data, format
  end

  get '/lines/:lines/:fields' do
    content_type :json
    # Split on '.' for possible format suffix
    output_fields = params[:fields].split('.')[0].split(',')
    format = params[:fields].split('.')[1]

    @data = find_data(params[:lines], 'lines', output_fields)
    respond @data, format
  end

  get '/lines/:lines' do
    content_type :json
  
    lines = params[:lines]
    @data = find_data(params[:lines], 'lines')
    respond @data
  end

end
