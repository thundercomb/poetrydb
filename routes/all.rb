require 'sinatra'

class Web < Sinatra::Base

  get '/:key' do
    content_type :json
   
    search_key = params[:key]
    if ['author', 'authors', 'title', 'titles'].include? search_key
      @data = find_list(search_key.chomp('s'))
    else
      @data = json_status(
        405,"#{search_key} list not available. Only author and title allowed."
      )
    end
    respond @data
  end

  get '/:keys/:search/all.?:format?' do
    content_type :json

    output_format = params[:format]
    unless output_format == nil or ['text', 'json'].include? output_format
      return json_status(
        405,"#{output_format} output format not available. Only text and json allowed."
      )
    end

    begin
      search_hash = format_input(params[:keys],params[:search])
    rescue Exception => e
      if e.message == '405'
        return json_status(
          '405', "Comma delimited fields must have corresponding semicolon delimited search terms, eg. /title,author/Winter;Shakespeare/all"
        )
      end
    end

    @data = new_find_data(search_hash)
    respond @data, output_format
  end

  get '/:keys/:search/:fields' do
    content_type :json

    # Split on '.' for possible format suffix
    output_format = params[:fields].split('.')[1]
    unless output_format == nil or ['text', 'json'].include? output_format
      return json_status(
        405,"#{output_format} output format not available. Only text and json allowed."
      )
    end
    begin
      search_hash = format_input(params[:keys],params[:search])
    rescue Exception => e
      if e.message == '405'
        return json_status(
          '405', "Comma delimited fields must have corresponding semicolon delimited search terms, eg. /title,author/Winter;Shakespeare/lines"
        )
      end
    end

    output_fields = Hash.new
    # Unset _id field and enable the others
    output_fields['_id'] = 0
    params[:fields].split('.')[0].split(',').each do |field|
      unless ['author', 'title', 'lines', 'linecount'].include? field
        return json_status(
          405,"#{field} output field not available. Only author, title, lines, and linecount allowed."
        )
      end
      output_fields["#{field}"] = 1
    end
      
    @data = new_find_data(search_hash, output_fields)
    respond @data, output_format
  end 

  get '/:keys/:search' do
    content_type :json

    begin
      search_hash = format_input(params[:keys],params[:search])
    rescue Exception => e
      if e.message == '405'
        return json_status(
          '405', 'Comma delimited fields must have corresponding semicolon delimited search terms, eg. /title,author/Winter;Shakespeare'
        )
      end
    end

    @data = new_find_data(search_hash)
    respond @data
  end
end
