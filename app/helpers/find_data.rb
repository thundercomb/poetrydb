require 'sinatra'

class Web < Sinatra::Base

  def new_find_data(search_hash, output_fields = { '_id' => 0, 'title' => 1, 'author' => 1, 'lines' => 1, 'linecount' => 1 })
    settings.poetry_coll.find(
      search_hash, { :projection => output_fields }
    ).to_a
  end

end
