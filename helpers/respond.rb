require 'sinatra'

class Web < Sinatra::Base

  def respond(data, format='json')
    if @data.length > 0
      #@data.each { |poem| poem.delete('_id') }
      if format.nil?
        response_format @data, request.accept
      else
        response_format @data, format, 'suffix'
      end
    else
      json_status 404, "Not found"
    end
  end

end
