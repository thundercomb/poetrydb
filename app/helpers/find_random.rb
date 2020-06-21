require 'sinatra'

class Web < Sinatra::Base

  def find_random()
    settings.poetry_coll.aggregate(
      [
        { "$sample": { "size": 1} },
        { "$project": { '_id' => 0, 'title' => 1, 'author' => 1, 'lines' => 1, 'linecount' => 1} }
      ]
    ).each { |i| @findings_data = i  }
    @findings_data
  end

end
