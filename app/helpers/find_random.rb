require 'sinatra'

class Web < Sinatra::Base

  def find_random(count, search_hash = {}, output_fields = { '_id' => 0, 'title' => 1, 'author' => 1, 'lines' => 1, 'linecount' => 1 })
    @findings_data = []
    settings.poetry_coll.aggregate(
      [
        { "$match": search_hash },
        { "$sample": { "size": count} },
        { "$project": output_fields }
      ]
    ).each { |i| @findings_data.append(i)  }
    @findings_data
  end

end
