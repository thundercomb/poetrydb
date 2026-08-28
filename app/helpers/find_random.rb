require 'sinatra'

class Web < Sinatra::Base

  def find_random(count, search_hash = {}, output_fields = { '_id' => 0, 'title' => 1, 'author' => 1, 'lines' => 1, 'linecount' => 1 }, axis = nil)
    return find_random_by_author(count, search_hash, output_fields) if axis == 'author'

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

  # Uniform over authors: pick `count` distinct authors at random (from those
  # matching search_hash) and return one random poem for each. A poet with many
  # poems is no more likely to appear than a poet with a single poem. If count
  # exceeds the number of matching authors, every matching author is returned.
  def find_random_by_author(count, search_hash = {}, output_fields = { '_id' => 0, 'title' => 1, 'author' => 1, 'lines' => 1, 'linecount' => 1 })
    authors = settings.poetry_coll.distinct('author', search_hash)
    results = []
    authors.sample(count).each do |author|
      results.concat(find_random(1, search_hash.merge('author' => author), output_fields))
    end
    results
  end

end
