require 'sinatra'

class Web < Sinatra::Base

  get '/linecount/:linecount/all.?:format?' do
    content_type :json
    format = params[:format]
  
    @data = find_data(params[:linecount].to_i, 'linecount')
    respond @data, format
  end

  get '/linecount/:linecount/:fields' do
    content_type :json
    # Split on '.' for possible format suffix
    output_fields = params[:fields].split('.')[0].split(',')
    format = params[:fields].split('.')[1]

    @data = find_data(params[:linecount].to_i, 'linecount', output_fields)
    respond @data, format
  end

  get '/linecount/:linecount' do
    content_type :json
    linecount = params[:linecount].to_i
  
    @data = find_data(params[:linecount].to_i, 'linecount')
    respond @data
  end
end
