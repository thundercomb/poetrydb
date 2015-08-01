require 'sinatra'

class Web < Sinatra::Base

  def format_input(search_keys, search_terms)
    search_hash = Hash[search_keys.split(',').zip(search_terms.split(';'))]
    search_hash.keys.each do |key|
      if search_hash["#{key}"] == nil
        raise "405"
      elsif search_hash["#{key}"][-4..-1].eql? ':abs'
        search_hash["#{key}"] = search_hash["#{key}"][0..-5]
      else
        search_hash["#{key}"] = /#{search_hash[key]}/
      end
    end
    search_hash
  end

end
