require 'sinatra'

class Web < Sinatra::Base

  def format_input(search_keys, search_terms)
    search_hash = Hash[search_keys.split(',').zip(search_terms.split(';'))]
    search_hash.keys.each do |key|
      if search_hash["#{key}"] == nil
        raise "405"
      elsif key == 'linecount'
        # linecount is a string field in the database
        # use cast to integer and back as trick to drop modifiers like ':abs'
        search_hash["#{key}"] = search_hash["#{key}"].to_i.to_s
      elsif key == 'poemcount' or key == 'random'
        # poemcount should be an integer - cast drops modifiers like ':abs'
        search_hash["#{key}"] = search_hash["#{key}"].to_i
      elsif search_hash["#{key}"][-4..-1].eql? ':abs'
        search_hash["#{key}"] = search_hash["#{key}"][0..-5]
      else
        search_value = search_hash[key].gsub("(","\\(").gsub(")","\\)")
        search_hash["#{key}"] = /#{search_value}/i
      end
    end
    search_hash
  end

end
