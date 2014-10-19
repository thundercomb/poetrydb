require 'sinatra'

class Web < Sinatra::Base

  def format_input(search_keys, search_terms)
    if search_terms[-4..-1].eql? ':abs'
      search_terms = search_terms[0..-5]
      abs = true
    else
      abs = false
    end

    search_hash = Hash[search_keys.split(',').zip(search_terms.split(';'))]
    search_hash.keys.each do |key|
      if search_hash["#{key}"] == nil
        raise "405"
      elsif key == "linecount"
        search_hash["linecount"] = search_hash["linecount"].to_i
      elsif !abs
        search_hash["#{key}"] = /#{search_hash[key]}/
      end
    end
    search_hash
  end

end
