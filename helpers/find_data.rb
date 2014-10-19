require 'sinatra'

class Web < Sinatra::Base

#  def find_data(search_term, field_type,
#                output_fields = ['title','author','lines','linecount'])
#    output_fields['_id'] = 0 #we are not interested in _id field
#    if search_term.class.eql? Fixnum
#      settings.poetry_coll.find(
#        {"#{field_type}" => search_term}, :fields => output_fields
#      ).to_a
#    elsif search_term[-4..-1].eql? ':abs'
#      settings.poetry_coll.find(
#        {"#{field_type}" => search_term[0..-5]}, :fields => output_fields
#      ).to_a
#    else
#      settings.poetry_coll.find(
#        {"#{field_type}" => /#{search_term}/}, :fields => output_fields
#      ).to_a
#    end
#  end

  def new_find_data(search_hash, output_fields = { '_id' => 0, 'title' => 1, 'author' => 1, 
                                                   'lines' => 1, 'linecount' => 1 })
    settings.poetry_coll.find(
      search_hash, :fields => output_fields
    ).to_a
  end

end
