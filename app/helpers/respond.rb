require 'sinatra'

class Web < Sinatra::Base

  def respond(data, format='json')
    # find_data signals an over-cap result set with a sentinel rather than a
    # poem array (see MAX_RESULTS); turn it into a friendly, actionable message.
    if @data.is_a?(Hash) && @data['over_limit']
      return json_status(
        '413',
        "Your search matched more than #{@data['over_limit']} poems. Please " \
        "narrow your search, or limit the number returned with poemcount, " \
        "eg. /author,poemcount/Dickinson;50."
      )
    end

    if @data.length > 0
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
