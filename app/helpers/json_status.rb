require 'sinatra'

class Web < Sinatra::Base

  def json_status(code, reason)
    [{
      :status => code,
      :reason => reason
    }.to_json]
  end

end
