require 'sinatra'

class Web < Sinatra::Base

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

end
