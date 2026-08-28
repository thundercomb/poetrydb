require 'sinatra'

class Web < Sinatra::Base

  def format_input(search_keys, search_terms)
    keys = search_keys.split(',')
    terms = search_terms.split(';')

    # Union (OR) search: several input fields but a single search term means
    # "match this term in ANY of the given fields", eg. /title,lines/roland
    # is the union of /title/roland and /lines/roland. Restricted to the
    # free-text fields; the other fields have no meaningful union.
    if keys.length > 1 and terms.length == 1
      raise "405" unless (keys - ['author', 'title', 'lines']).empty?
      return { '$or' => keys.map { |key| { key => search_regex(terms.first) } } }
    end

    search_hash = Hash[keys.zip(terms)]
    search_hash.keys.each do |key|
      if search_hash["#{key}"] == nil
        raise "405"
      elsif key == 'linecount'
        value = search_hash["#{key}"]
        range = value.match(/\A(\d*)-(\d*)\z/)
        if range and not (range[1].empty? and range[2].empty?)
          # Range query: "14-20" (14..20), "-14" (<= 14), "14-" (>= 14).
          # linecount is stored as a string, so compare numerically via $toInt.
          bounds = []
          bounds << { '$gte' => [{ '$toInt' => '$linecount' }, range[1].to_i] } unless range[1].empty?
          bounds << { '$lte' => [{ '$toInt' => '$linecount' }, range[2].to_i] } unless range[2].empty?
          search_hash.delete("#{key}")
          (search_hash['$and'] ||= []) << { '$expr' => { '$and' => bounds } }
        else
          # linecount is a string field in the database
          # use cast to integer and back as trick to drop modifiers like ':abs'
          search_hash["#{key}"] = value.to_i.to_s
        end
      elsif key == 'random'
        value = search_hash["#{key}"]
        # optional axis modifier: "5:author" => 5 poems, each by a random author
        if value.end_with?(':author')
          search_hash['random_axis'] = 'author'
          value = value[0...-':author'.length]
        end
        search_hash["#{key}"] = value.to_i
      elsif key == 'poemcount'
        # poemcount should be an integer - cast drops modifiers like ':abs'
        search_hash["#{key}"] = search_hash["#{key}"].to_i
      else
        search_hash["#{key}"] = search_regex(search_hash["#{key}"])
      end
    end
    search_hash
  end

  # Build the MongoDB match value for a free-text field (author/title/lines).
  # ":abs" means an exact, whole-field match; ":word" matches the term as a
  # whole word ("eleven" but not "eleventh"); otherwise the term matches any
  # part of the field (case-insensitive substring).
  def search_regex(value)
    if value.end_with?(':abs')
      value[0...-':abs'.length]
    elsif value.end_with?(':word')
      word = value[0...-':word'.length].gsub("(", "\\(").gsub(")", "\\)")
      /\b#{word}\b/i
    else
      escaped = value.gsub("(", "\\(").gsub(")", "\\)")
      /#{escaped}/i
    end
  end

end
