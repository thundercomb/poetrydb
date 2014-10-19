require 'sinatra'

class Web < Sinatra::Base

  def find_list(field)
    @field_data = settings.poetry_coll.find(
      { "#{field}" => /./ }, :fields => { '_id' => 0, "#{field}" => 1 }
    ).sort_by {
      |poem| poem["#{field}"]
    }.uniq {
      |poem| poem["#{field}"]
    }
    field_array = Array.new;
    @field_data.each { |i| field_array.push(i["#{field}"]) }
    { "#{field}s" => field_array }
  end

end
