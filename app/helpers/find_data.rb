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
    # otherwise return all matching documents, up to MAX_RESULTS. Check the
    # match count CHEAPLY first (a capped server-side count that transfers no
    # documents); only materialise the poems once we know the set is within the
    # cap. Fetching even MAX_RESULTS+1 full poems just to count them is slow,
    # because the `lines` arrays are large — a broad substring like /e/i matches
    # almost the whole corpus and would time the worker out before any cap could
    # apply. Over the cap, signal the caller to return a friendly message.
    else
      if settings.poetry_coll.count_documents(search_hash, :limit => MAX_RESULTS + 1) > MAX_RESULTS
        return { 'over_limit' => MAX_RESULTS }
      end

      @findings_data = settings.poetry_coll.find(
        search_hash, { :projection => output_fields }
      ).to_a
    end

    @findings_data
  end

end
