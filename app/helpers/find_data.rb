require 'sinatra'

class Web < Sinatra::Base

  # Upper bound on an unbounded (no poemcount / no random) result set. A
  # single broad substring like /lines/e can otherwise match (almost) the whole
  # corpus, producing a multi-megabyte response that ties up the worker past
  # Heroku's router window (503, issues #68/#69). Overridable via env for tests.
  MAX_RESULTS = (ENV['MAX_RESULTS'] || 500).to_i

  def find_data(search_hash, output_fields = { '_id' => 0, 'title' => 1, 'author' => 1, 'lines' => 1, 'linecount' => 1, 'source' => 1 })
    # limit returned documents if 'poemcount' key available
    if search_hash.keys.include?('poemcount')
      poemcount = search_hash['poemcount']
      search_hash.delete('poemcount')

      @findings_data = settings.poetry_coll.find(
        search_hash, { :projection => output_fields }
      ).limit( poemcount ).to_a
    # return sample of returned documents
    elsif search_hash.keys.include?('random')
      randomcount = search_hash['random']
      search_hash.delete('random')
      random_axis = search_hash.delete('random_axis')

      @findings_data = find_random(randomcount, search_hash, output_fields, random_axis)
    # otherwise return all matching documents, up to MAX_RESULTS. Fetch one more
    # than the cap so we can tell "exactly at the cap" from "over the cap"
    # without a separate count query; over the cap, signal the caller to return
    # a friendly "narrow your search" message instead of a huge payload.
    else
      results = settings.poetry_coll.find(
        search_hash, { :projection => output_fields }
      ).limit(MAX_RESULTS + 1).to_a

      return { 'over_limit' => MAX_RESULTS } if results.length > MAX_RESULTS

      @findings_data = results
    end

    @findings_data
  end

end
