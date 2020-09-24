require 'sinatra'

class Web < Sinatra::Base

  def find_random(count, output_fields = { '_id' => 0, 'title' => 1, 'author' => 1, 'lines' => 1, 'linecount' => 1 })
    @findings_data = []
    settings.poetry_coll.aggregate(
      [
        { "$sample": { "size": count} },
        { "$project": output_fields }
      ]
    ).each { |i| @findings_data.append(i)  }
    @findings_data
  end

end
