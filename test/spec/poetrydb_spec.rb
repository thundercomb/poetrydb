require 'rspec'
require 'spec_helper'

# 200

describe('Home page:', {:type => :feature}) do
  it('view home page') do
    response = TestHttp.get('/')
    expect(response.body).to include('PoetryDB is the world\'s first API for next generation internet poets')
    expect(response.code).to be 200
  end
end

describe('Author search:', {:type => :feature}) do

  it('List all authors using /author') do
    response = TestHttp.get('/author')
    expect(response.body).to include('Ernest Dowson')
    expect(response.body).to include('Emily Dickinson')
    expect(response.code).to be 200
  end

  it('List all authors using /authors') do
    response = TestHttp.get('/authors')
    expect(response.body).to include('Ernest Dowson')
    expect(response.body).to include('Emily Dickinson')
    expect(response.code).to be 200
  end

  it('Search by author') do
    response = TestHttp.get('/author/Dowson')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by author; return some output fields; format as text') do
    response = TestHttp.get('/author/Dowson/title,lines,author.text')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include("title\n")
    expect(response.body).to include("author\n")
    expect(response.body).to include("lines\n")
    expect(response.body).not_to include("linecount\n")
    expect(response.code).to be 200
  end

  it('Search by author; return some output fields; format as json') do
    response = TestHttp.get('/author/Dowson/title,lines,author.json')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).not_to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by author; return all output fields') do
    response = TestHttp.get('/author/Dowson/all')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by author; return all output fields; format as text') do
    response = TestHttp.get('/author/Dowson/all.text')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include("title\n")
    expect(response.body).to include("author\n")
    expect(response.body).to include("lines\n")
    expect(response.body).to include("linecount\n")
    expect(response.code).to be 200
  end

  it('Search by author; return all output fields; format as json') do
    response = TestHttp.get('/author/Dowson/all.json')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

end

describe('Title search:', {:type => :feature}) do

  it('List all titles, method 1') do
    response = TestHttp.get('/title')
    expect(response.body).to include('Bereavement in their death to feel')
    expect(response.body).to include('Said Death to Passion')
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.code).to be 200
  end

  it('List all titles, method 2') do
    response = TestHttp.get('/titles')
    expect(response.body).to include('Bereavement in their death to feel')
    expect(response.body).to include('Said Death to Passion')
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.code).to be 200
  end

  it('Search by title') do
    response = TestHttp.get("/title/The%20Moon%20Maiden's%20Song")
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by title; return some output fields; format as text') do
    response = TestHttp.get("/title/The%20Moon%20Maiden's%20Song/title,lines,author.text")
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include("title\n")
    expect(response.body).to include("author\n")
    expect(response.body).to include("lines\n")
    expect(response.body).not_to include("linecount\n")
    expect(response.code).to be 200
  end

  it('Search by title; return some output fields; format as json') do
    response = TestHttp.get("/title/The%20Moon%20Maiden's%20Song/title,lines,author.json")
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).not_to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by title; return all output fields') do
    response = TestHttp.get("/title/The%20Moon%20Maiden's%20Song/all")
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by title; return all output fields; format as text') do
    response = TestHttp.get("/title/The%20Moon%20Maiden's%20Song/all.text")
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include("title\n")
    expect(response.body).to include("author\n")
    expect(response.body).to include("lines\n")
    expect(response.body).to include("linecount\n")
    expect(response.code).to be 200
  end

  it('Search by title; return all output fields; format as json') do
    response = TestHttp.get("/title/The%20Moon%20Maiden's%20Song/all.json")
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

end

describe('Lines search:', {:type => :feature}) do

  it('Search by lines') do
    response = TestHttp.get('/lines/Love%20stays%20a%20summer%20night')
    expect(response.body).to include("The Moon Maiden's Song")
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by lines; return some output fields; format as text') do
    response = TestHttp.get('/lines/Love%20stays%20a%20summer%20night/title,lines,author.text')
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include("title\n")
    expect(response.body).to include("author\n")
    expect(response.body).to include("lines\n")
    expect(response.body).not_to include("linecount\n")
    expect(response.code).to be 200
  end

  it('Search by lines; return some output fields; format as json') do
    response = TestHttp.get('/lines/Love%20stays%20a%20summer%20night/title,lines,author.json')
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).not_to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by lines; return all output fields') do
    response = TestHttp.get('/lines/Love%20stays%20a%20summer%20night/all')
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by lines; return all output fields; format as text') do
    response = TestHttp.get('/lines/Love%20stays%20a%20summer%20night/all.text')
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include("title\n")
    expect(response.body).to include("author\n")
    expect(response.body).to include("lines\n")
    expect(response.body).to include("linecount\n")
    expect(response.code).to be 200
  end

  it('Search by lines; return all output fields; format as json') do
    response = TestHttp.get('/lines/Love%20stays%20a%20summer%20night/all.json')
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

end

describe('Linecount search:', {:type => :feature}) do

  it('Search by linecount') do
    response = TestHttp.get('/linecount/16')
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by maximum linecount (open-ended range)') do
    response = TestHttp.get('/linecount/-9')
    # <= 9 lines: numeric comparison, not lexical ("12"/"16" must be excluded)
    expect(response.body).to include('Said Death to Passion')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).not_to include('The Moon Maiden\'s Song')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by minimum linecount (open-ended range)') do
    response = TestHttp.get('/linecount/12-')
    # >= 12 lines
    expect(response.body).to include('Bereavement in their death to feel')
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.body).not_to include('Said Death to Passion')
    expect(response.code).to be 200
  end

  it('Search by linecount range (both bounds)') do
    response = TestHttp.get('/linecount/9-12')
    # 9..12 lines inclusive
    expect(response.body).to include('Said Death to Passion')
    expect(response.body).to include('Bereavement in their death to feel')
    expect(response.body).not_to include('The Moon Maiden\'s Song')
    expect(response.code).to be 200
  end

  it('Exact linecount still matches (no range)') do
    response = TestHttp.get('/linecount/12')
    expect(response.body).to include('Bereavement in their death to feel')
    expect(response.body).not_to include('The Moon Maiden\'s Song')
    expect(response.body).not_to include('Said Death to Passion')
    expect(response.code).to be 200
  end

  it('Combine maximum linecount with random') do
    response = TestHttp.get('/linecount,random/-9;5')
    # only poems with <= 9 lines are eligible for the random sample
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).not_to include('The Moon Maiden\'s Song')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by linecount; return some output fields; format as text') do
    response = TestHttp.get('/linecount/16/title,lines,author.text')
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include("title\n")
    expect(response.body).to include("author\n")
    expect(response.body).to include("lines\n")
    expect(response.body).not_to include("linecount\n")
    expect(response.code).to be 200
  end

  it('Search by lines; return some output fields; format as json') do
    response = TestHttp.get('/linecount/16/title,lines,author.json')
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).not_to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by lines; return all output fields') do
    response = TestHttp.get('/linecount/16/all')
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by lines; return all output fields; format as text') do
    response = TestHttp.get('/linecount/16/all.text')
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include("title\n")
    expect(response.body).to include("author\n")
    expect(response.body).to include("lines\n")
    expect(response.body).to include("linecount\n")
    expect(response.code).to be 200
  end

  it('Search by lines; return all output fields; format as json') do
    response = TestHttp.get('/linecount/16/all.json')
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

end

describe('Poemcount search:', {:type => :feature}) do

  it('Find 1 poem') do
    response = TestHttp.get('/poemcount/1')
    expect(response.body).not_to include('},')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Find 1 poem; return some output fields; format as text') do
    response = TestHttp.get('/poemcount/1/title,lines,author.text')
    expect(response.body).not_to include('},')
    expect(response.body).to include("title\n")
    expect(response.body).to include("author\n")
    expect(response.body).to include("lines\n")
    expect(response.body).not_to include("linecount\n")
    expect(response.code).to be 200
  end

  it('Find 1 poem; return some output fields; format as json') do
    response = TestHttp.get('/poemcount/1/title,lines,author.json')
    expect(response.body).not_to include('},')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).not_to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Find 1 poem; return all output fields') do
    response = TestHttp.get('/poemcount/1/all')
    expect(response.body).not_to include('},')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Find 1 poem; return all output fields; format as text') do
    response = TestHttp.get('/poemcount/1/all.text')
    expect(response.body).not_to include('},')
    expect(response.body).to include("title\n")
    expect(response.body).to include("author\n")
    expect(response.body).to include("lines\n")
    expect(response.body).to include("linecount\n")
    expect(response.code).to be 200
  end

  it('Find 1 poem; return all output fields; format as json') do
    response = TestHttp.get('/poemcount/1/all.json')
    expect(response.body).not_to include('},')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Find 2 poems; return all output fields; format as json') do
    response = TestHttp.get('/poemcount/2/all.json')
    expect(response.body).to include('},')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

end

describe('Random search:', {:type => :feature}) do

  it('Find 1 random poem') do
    response = TestHttp.get('/random/1')
    expect(response.body).not_to include('},')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Find 1 random poem; return some output fields; format as text') do
    response = TestHttp.get('/random/1/title,lines,author.text')
    expect(response.body).not_to include('},')
    expect(response.body).to include("title\n")
    expect(response.body).to include("author\n")
    expect(response.body).to include("lines\n")
    expect(response.body).not_to include("linecount\n")
    expect(response.code).to be 200
  end

  it('Find 1 random poem; return some output fields; format as json') do
    response = TestHttp.get('/random/1/title,lines,author.json')
    expect(response.body).not_to include('},')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).not_to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Find 1 random poem; return all output fields') do
    response = TestHttp.get('/random/1/all')
    expect(response.body).not_to include('},')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Find 1 random poem; return all output fields; format as text') do
    response = TestHttp.get('/random/1/all.text')
    expect(response.body).not_to include('},')
    expect(response.body).to include("title\n")
    expect(response.body).to include("author\n")
    expect(response.body).to include("lines\n")
    expect(response.body).to include("linecount\n")
    expect(response.code).to be 200
  end

  it('Find 1 random poem; return all output fields; format as json') do
    response = TestHttp.get('/random/1/all.json')
    expect(response.body).not_to include('},')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Find 2 random poems; return all output fields; format as json') do
    response = TestHttp.get('/random/2/all.json')
    expect(response.body).to include('},')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Random by author returns one poem per distinct author') do
    response = TestHttp.get('/random/10:author')
    authors = response.parsed_response.map { |p| p['author'] }
    # test corpus has 3 authors (Emily Dickinson has 2 poems); author-uniform
    # collapses her to one, so exactly 3 poems come back, no author repeated
    expect(response.parsed_response.length).to eq 3
    expect(authors.uniq.length).to eq 3
    expect(authors.sort).to eq ['Bob Willett', 'Emily Dickinson', 'Ernest Dowson']
    expect(response.code).to be 200
  end

  it('Random by author with count below the number of authors') do
    response = TestHttp.get('/random/2:author')
    authors = response.parsed_response.map { |p| p['author'] }
    expect(response.parsed_response.length).to eq 2
    expect(authors.uniq.length).to eq 2   # still one poem per distinct author
    expect(response.code).to be 200
  end

  it('Random by author composes with a linecount filter') do
    response = TestHttp.get('/linecount,random/-9;10:author')
    authors = response.parsed_response.map { |p| p['author'] }
    titles = response.parsed_response.map { |p| p['title'] }
    # <= 9 lines eligible: 'Said Death to Passion' (Dickinson, 9) and the 1-line Bob Willett poem
    expect(response.parsed_response.length).to eq 2
    expect(authors.sort).to eq ['Bob Willett', 'Emily Dickinson']
    expect(titles).to include('Said Death to Passion')                 # Dickinson's only <= 9 poem
    expect(titles).not_to include('Bereavement in their death to feel') # her 12-line poem
    expect(response.body).not_to include('The Moon Maiden\'s Song')     # Dowson, 16 lines
    expect(response.code).to be 200
  end

end

describe('Combination search:', {:type => :feature}) do
  it('Search by author, title; return some output fields; format as json') do
    response = TestHttp.get('/author,title/Dowson;Moon/title,lines,linecount')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).to include('"title":')
    expect(response.body).not_to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by author, linecount (exactly); return some output fields') do
    response = TestHttp.get('/author,linecount/Dowson;16:abs/title,lines,linecount')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).to include('"title":')
    expect(response.body).not_to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by author, title') do
    response = TestHttp.get('/author,title/Dickinson;Said%20Death%20to%20Passion')
    expect(response.body).to include('And the Debate was done.')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by author, title (exactly)') do
    response = TestHttp.get('/author,title/Dickinson;Said%20Death%20to%20Passion:abs')
    expect(response.body).to include('And the Debate was done.')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by author (exactly), title (exactly)') do
    response = TestHttp.get('/author,title/Emily%20Dickinson:abs;Said%20Death%20to%20Passion:abs')
    expect(response.body).to include('And the Debate was done.')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by author, title, linecount') do
    response = TestHttp.get('/author,title,linecount/Emily%20Dickinson;Said%20Death%20to%20Passion;9')
    expect(response.body).to include('And the Debate was done.')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by author (exactly), title (exactly), linecount (exactly)') do
    response = TestHttp.get('/author,title,linecount/Emily%20Dickinson:abs;Said%20Death%20to%20Passion:abs;9:abs')
    expect(response.body).to include('And the Debate was done.')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by author, lines, up to 1 poem') do
    response = TestHttp.get('/author,lines,poemcount/Dickinson;Death%20to;1')
    expect(response.body).to include('Bereavement in their death to feel')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by author, lines, up to 2 poems') do
    response = TestHttp.get('/author,lines,poemcount/Dickinson;Death%20to;2')
    expect(response.body).to include('Bereavement in their death to feel')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('And the Debate was done.')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by author, lines, up to 1000 poems') do
    response = TestHttp.get('/author,lines,poemcount/Dickinson;Death%20to;1000')
    expect(response.body).to include('Bereavement in their death to feel')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('And the Debate was done.')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by author, lines, up to 1 poem; return all output fields; format as text') do
    response = TestHttp.get('/author,lines,poemcount/Dickinson;Death%20to;1/all.text')
    expect(response.body).to include('Bereavement in their death to feel')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).to include("title\n")
    expect(response.body).to include("author\n")
    expect(response.body).to include("lines\n")
    expect(response.body).to include("linecount\n")
    expect(response.code).to be 200
  end

  it('Search by author, lines, up to 1 poem; return some output fields; format as json') do
    response = TestHttp.get('/author,lines,poemcount/Dickinson;Death%20to;1/lines.json')
    expect(response.body).to include('Bereavement in their death to feel')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('"title":')
    expect(response.body).not_to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).not_to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by author, up to 1 random poem') do
    response = TestHttp.get('/author,random/Dickinson;1')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"Emily Dickinson"')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by author, up to 1 random poem; return some output fields') do
    response = TestHttp.get('/author,random/Dickinson;1/author,lines')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).not_to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"Emily Dickinson"')
    expect(response.body).to include('"lines":')
    expect(response.body).not_to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by author, title, up to 1 random poem; return some output fields') do
    response = TestHttp.get('/author,title,random/Dickinson;Death%20to;1/title,lines')
    expect(response.body).to include('eath to')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('"title":')
    expect(response.body).not_to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).not_to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search by author, title, up to 2 random poems; return some output fields') do
    response = TestHttp.get('/author,random/Dickinson;2')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"Emily Dickinson"')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('},')
    expect(response.code).to be 200
  end
end

# 404

describe('Combination search with no results:', {:type => :feature}) do
  describe('view author, linecount of poems by author that contains number of lines', {:type => :feature}) do
    it('Search by author, linecount when no linecount matches') do
      response = TestHttp.get('/author,linecount/Dowson;6/title,lines,linecount')
      expect(response.body).not_to include('Love stays a summer night')
      expect(response.body).to include('404')
      expect(response.body).to include('Not found')
      expect(response.code).to be 200
    end
  end

  it('Search by author, linecount (exactly) when no linecount matches') do
    response = TestHttp.get('/author,linecount/Dowson;6:abs/title,lines,linecount')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('404')
    expect(response.body).to include('Not found')
    expect(response.code).to be 200
  end

  it('Search by author, title (exactly) when no title matches') do
    response = TestHttp.get('/author,title/Dickinson;Said:abs')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).to include('404')
    expect(response.body).to include('Not found')
    expect(response.code).to be 200
  end

  it('Search by author (exactly), title (exactly) when no author matches') do
    response = TestHttp.get('/author,title/Dickinson:abs;Said%20Death%20to%20Passion:abs')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).to include('404')
    expect(response.body).to include('Not found')
    expect(response.code).to be 200
  end
end

# 405

describe('Search with invalid input fields:', {:type => :feature}) do
  it('Search by invalid input field') do
    response = TestHttp.get('/wrong')
    expect(response.body).to include('405')
    expect(response.body).to include('list not available. Only author and title allowed.')
    expect(response.code).to be 200
  end

  it('Search by invalid input field, with corresponding search field') do
    response = TestHttp.get('/wrong/Dowson')
    expect(response.body).to include('405')
    expect(response.body).to include('input field not available. Only author, title, lines, linecount, and poemcount or random allowed.')
    expect(response.code).to be 200
  end

  it('Search by invalid input field; return all output fields; format by text') do
    response = TestHttp.get('/wrong/Dowson/all.text')
    expect(response.body).to include('405')
    expect(response.body).to include('input field not available. Only author, title, lines, linecount, and poemcount or random allowed.')
    expect(response.code).to be 200
  end

  it('Search by invalid input field; return all output fields; format by json') do
    response = TestHttp.get('/wrong/Dowson/all.json')
    expect(response.body).to include('405')
    expect(response.body).to include('input field not available. Only author, title, lines, linecount, and poemcount or random allowed.')
    expect(response.code).to be 200
  end

  it('Search by combination of invalid and valid input fields (exactly); return some output fields') do
    response = TestHttp.get('/wrong,linecount/Dowson;16:abs/title,lines,linecount')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('405')
    expect(response.body).to include('input field not available. Only author, title, lines, linecount, and poemcount or random allowed.')
    expect(response.code).to be 200
  end
end

describe('Search with invalid output fields:', {:type => :feature}) do
  it('Search by author; return some output fields; format as invalid format') do
    response = TestHttp.get('/author/Dowson/title,lines,author.wrong')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('405')
    expect(response.code).to be 200
  end

  it('Search by author; return all output fields; format as invalid format') do
    response = TestHttp.get('/author/Dowson/all.wrong')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('405')
    expect(response.code).to be 200
  end

  it('Search by author; return invalid output field') do
    response = TestHttp.get('/author/Dowson/titles')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('405')
    expect(response.code).to be 200
  end

  it('Union search: one term across multiple fields matches via author') do
    response = TestHttp.get('/author,title/Dowson')
    # author,title with a single term => union: author~Dowson OR title~Dowson
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.body).to include('Ernest Dowson')
    expect(response.body).not_to include('Comma delimited fields must have corresponding')
    expect(response.code).to be 200
  end

  it('Union search: one term across multiple fields; return all output fields; format as json') do
    response = TestHttp.get('/author,title/Dowson/all.json')
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.body).to include('"linecount":')
    expect(response.body).not_to include('Comma delimited fields must have corresponding')
    expect(response.code).to be 200
  end

  it('Search by author; return combination of valid and invalid output fields') do
    response = TestHttp.get('/author/Dowson/wrong,lines')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('405')
    expect(response.code).to be 200
  end

  it('Search by author; return combination of valid and invalid output fields; format as text') do
    response = TestHttp.get('/author/Dowson/wrong,lines.text')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('405')
    expect(response.code).to be 200
  end

  it('Search by author; return combination of valid and invalid output fields; format as invalid format') do
    response = TestHttp.get('/author/Dowson/wrong,lines.bad')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('405')
    expect(response.code).to be 200
  end
end

describe('Search by invalid input field combinations:', {:type => :feature}) do
  it('Search by poemcount and random') do
    response = TestHttp.get('/poemcount,random/1;1')
    expect(response.body).to include('405')
    expect(response.body).to include('Use either poemcount or random as input fields, but not both.')
    expect(response.body).not_to include('"title":')
    expect(response.code).to be 200
  end

  it('Search by poemcount and random; return all fields; format as text') do
    response = TestHttp.get('/poemcount,random/1;1/all.text')
    expect(response.body).to include('405')
    expect(response.body).to include('Use either poemcount or random as input fields, but not both.')
    expect(response.body).not_to include('"title":')
    expect(response.code).to be 200
  end

  it('Search by valid input field, poemcount, and random') do
    response = TestHttp.get('/author,poemcount,random/Dowson;1;1')
    expect(response.body).to include('405')
    expect(response.body).to include('Use either poemcount or random as input fields, but not both.')
    expect(response.body).not_to include('"title":')
    expect(response.code).to be 200
  end

  it('Search by valid input field, poemcount, and random; return all output fields; format as json') do
    response = TestHttp.get('/author,poemcount,random/Dowson;1;1/title.json')
    expect(response.body).to include('405')
    expect(response.body).to include('Use either poemcount or random as input fields, but not both.')
    expect(response.body).not_to include('"title":')
    expect(response.code).to be 200
  end

  it('Search by valid input fields and genuinely mismatched search terms') do
    response = TestHttp.get('/author,title,lines/Dowson;Death')
    # 3 fields but 2 terms is a real mismatch (neither AND nor union), so still 405
    expect(response.body).to include('405')
    expect(response.body).to include('Comma delimited fields must have corresponding semicolon delimited search terms')
    expect(response.body).not_to include('"title":')
    expect(response.code).to be 200
  end

  it('Union search rejected for non-text input fields') do
    response = TestHttp.get('/linecount,title/5')
    # union only applies to author/title/lines; linecount has no meaningful union
    expect(response.body).to include('405')
    expect(response.code).to be 200
  end

  it('Search for title with open round bracket') do
    response = TestHttp.get('/title/A%20Soap%20Opera%20(How')
    expect(response.body).to include('There it was ) oh no')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

  it('Search for lines with closing round bracket') do
    response = TestHttp.get('/lines/There%20it%20was%20)%20oh%20no')
    expect(response.body).to include('There it was ) oh no')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end

end

describe('Union search (single term across multiple fields):', {:type => :feature}) do

  it('Union reaches the lines field (reporter scenario: term in any field)') do
    response = TestHttp.get('/author,title,lines/summer')
    # 'summer' is only in the lines of "The Moon Maiden's Song"
    expect(response.parsed_response.length).to eq 1
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.code).to be 200
  end

  it('Union returns all poems matching in any field') do
    response = TestHttp.get('/author,lines/Dickinson')
    # author~Dickinson matches both of her poems (lines contain no "Dickinson")
    authors = response.parsed_response.map { |p| p['author'] }
    titles = response.parsed_response.map { |p| p['title'] }
    expect(response.parsed_response.length).to eq 2
    expect(authors.uniq).to eq ['Emily Dickinson']
    expect(titles).to include('Bereavement in their death to feel')
    expect(titles).to include('Said Death to Passion')
    expect(response.body).not_to include('The Moon Maiden\'s Song')
    expect(response.code).to be 200
  end

  it('Union honours the :abs modifier (exact match in any field)') do
    # exact author "Ernest Dowson" matches; a partial "Dowson:abs" matches nothing
    exact = TestHttp.get('/author,title/Ernest%20Dowson:abs')
    expect(exact.body).to include('The Moon Maiden\'s Song')
    expect(exact.code).to be 200

    partial = TestHttp.get('/author,title/Dowson:abs')
    expect(partial.body).to include('404')
    expect(partial.body).not_to include('The Moon Maiden\'s Song')
    expect(partial.code).to be 200
  end

  it('Intersection still works: multiple fields with matching terms are ANDed') do
    response = TestHttp.get('/author,title/Dickinson;Passion')
    # author~Dickinson AND title~Passion => only "Said Death to Passion"
    expect(response.parsed_response.length).to eq 1
    expect(response.body).to include('Said Death to Passion')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.code).to be 200
  end

  it('Intersection across title and lines with different terms') do
    response = TestHttp.get('/title,lines/Death;Passion')
    # title~Death AND lines~Passion => only "Said Death to Passion"
    expect(response.parsed_response.length).to eq 1
    expect(response.body).to include('Said Death to Passion')
    expect(response.body).not_to include('Bereavement in their death to feel')
    expect(response.code).to be 200
  end

end

describe('Exact word search (:word modifier):', {:type => :feature}) do

  it('Default (substring) matches a partial word') do
    response = TestHttp.get('/lines/win')
    # "win" appears inside "winged" in "The Moon Maiden's Song"
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.code).to be 200
  end

  it(':word excludes partial-word matches') do
    response = TestHttp.get('/lines/win:word')
    # no line contains "win" as a whole word, so nothing matches
    expect(response.body).to include('404')
    expect(response.body).not_to include('The Moon Maiden\'s Song')
    expect(response.code).to be 200
  end

  it(':word still matches a genuine whole word') do
    response = TestHttp.get('/lines/summer:word')
    # "summer" appears as a whole word ("summer night")
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.code).to be 200
  end

  it(':word composes with a union search') do
    response = TestHttp.get('/title,lines/summer:word')
    # union across title/lines, whole-word "summer" only in the lines
    expect(response.body).to include('The Moon Maiden\'s Song')
    expect(response.code).to be 200
  end

end

describe 'Author info endpoint' do
  # Bios are seeded from tools/test_authors.json: Emily Dickinson and Ernest
  # Dowson have fixture bios; Bob Willett has poems but NO bio.

  it('returns the biography for an exact author name') do
    response = TestHttp.get('/author/Emily%20Dickinson/info')
    bios = JSON.parse(response.body)
    expect(bios).to be_an(Array)
    expect(bios.length).to be 1
    expect(bios[0]['name']).to eq 'Emily Dickinson'
    expect(bios[0]['summary']).to include('American poet')
    expect(response.code).to be 200
  end

  it('matches by substring, like other author searches') do
    response = TestHttp.get('/author/Dickinson/info')
    bios = JSON.parse(response.body)
    expect(bios.length).to be 1
    expect(bios[0]['name']).to eq 'Emily Dickinson'
  end

  it('returns ALL matching biographies for a shared substring') do
    # "son" matches both Dickinson and Dowson
    response = TestHttp.get('/author/son/info')
    bios = JSON.parse(response.body)
    expect(bios.map { |b| b['name'] }).to eq ['Emily Dickinson', 'Ernest Dowson']
  end

  it(':abs requires an exact name') do
    response = TestHttp.get('/author/Emily%20Dickinson:abs/info')
    expect(JSON.parse(response.body)[0]['name']).to eq 'Emily Dickinson'

    response = TestHttp.get('/author/Dickinson:abs/info')
    expect(response.body).to include('404')
  end

  it('poem_count is computed live from the corpus, not the stored snapshot') do
    # fixture bio stores poem_count 362; the harness corpus holds 2 Dickinson poems
    response = TestHttp.get('/author/Emily%20Dickinson/info')
    expect(JSON.parse(response.body)[0]['poem_count']).to be 2

    # Dowson's fixture stores 999; the harness corpus holds 1
    response = TestHttp.get('/author/Dowson/info')
    expect(JSON.parse(response.body)[0]['poem_count']).to be 1
  end

  it('never serves editorial layers') do
    # the Dickinson fixture deliberately carries _provenance/_eval blocks
    response = TestHttp.get('/author/Emily%20Dickinson/info')
    expect(response.body).not_to include('_provenance')
    expect(response.body).not_to include('_eval')
    expect(response.body).not_to include('EDITORIAL_MUST_NOT_LEAK')
  end

  it('notable_poems carry the in_corpus cross-linking contract') do
    response = TestHttp.get('/author/Emily%20Dickinson/info')
    notable = JSON.parse(response.body)[0]['notable_poems']
    in_corpus = notable.select { |n| n['in_corpus'] }.map { |n| n['title'] }
    absent    = notable.reject { |n| n['in_corpus'] }.map { |n| n['title'] }
    expect(in_corpus).to include('Said Death to Passion')
    expect(absent).to include('Because I could not stop for Death')

    # an in_corpus title is fetchable directly, exactly as documented
    poem = TestHttp.get('/title/Said%20Death%20to%20Passion:abs')
    expect(poem.body).to include('Emily Dickinson')
  end

  it('known author without a bio explains the absence') do
    response = TestHttp.get('/author/Bob%20Willett/info')
    expect(response.body).to include('404')
    expect(response.body).to include('No biography available yet')
    expect(response.code).to be 200
  end

  it('unknown author returns a not-found status') do
    response = TestHttp.get('/author/Nonexistent%20Poet/info')
    expect(response.body).to include('404')
    expect(response.body).to include('No author found')
    expect(response.code).to be 200
  end
end

# The `source` output field carries per-poem provenance (edition + URL). It is
# part of the default response (like linecount) AND explicitly selectable, but
# only appears for poems that actually record a source. In the fixture, "Said
# Death to Passion" (Gutenberg 12242) and "The Moon Maiden's Song" (Gutenberg
# 8109) have a source; "Bereavement in their death to feel" does not.
describe('Source output field:', {:type => :feature}) do

  it('is present by default for a poem that records a source (json)') do
    response = TestHttp.get('/author/Dowson')
    expect(response.body).to include('"source":')
    expect(response.body).to include('https://www.gutenberg.org/ebooks/8109')
    expect(response.code).to be 200
  end

  it('is omitted by default for a poem with no recorded source') do
    response = TestHttp.get('/title/Bereavement%20in%20their%20death%20to%20feel')
    expect(response.body).to include('"title":')
    expect(response.body).not_to include('"source":')
    expect(response.code).to be 200
  end

  it('is included in the /all response') do
    response = TestHttp.get('/title/Said%20Death%20to%20Passion:abs/all')
    expect(response.body).to include('"source":')
    expect(response.body).to include('https://www.gutenberg.org/ebooks/12242')
    expect(response.code).to be 200
  end

  it('can be requested on its own as an output field') do
    response = TestHttp.get('/author/Dowson/source')
    expect(response.body).to include('"source":')
    expect(response.body).to include('https://www.gutenberg.org/ebooks/8109')
    expect(response.body).not_to include('"title":')
    expect(response.body).not_to include('"author":')
    expect(response.body).not_to include('"lines":')
    expect(response.body).not_to include('"linecount":')
    expect(response.code).to be 200
  end

  it('can be combined with other output fields') do
    response = TestHttp.get('/title/Said%20Death%20to%20Passion:abs/title,source')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"source":')
    expect(response.body).not_to include('"lines":')
    expect(response.body).not_to include('"linecount":')
    expect(response.code).to be 200
  end

  it('when explicitly requested, is absent for a poem with no source') do
    response = TestHttp.get('/title/Bereavement%20in%20their%20death%20to%20feel/title,source')
    expect(response.body).to include('"title":')
    expect(response.body).not_to include('"source":')
    expect(response.code).to be 200
  end

  it('renders in the text format') do
    response = TestHttp.get('/author/Dowson/source.text')
    expect(response.body).to include("source\n")
    expect(response.body).to include('https://www.gutenberg.org/ebooks/8109')
    expect(response.code).to be 200
  end

  it('is still rejected as an INPUT (search) field') do
    response = TestHttp.get('/source/Gutenberg')
    expect(response.body).to include('405')
    expect(response.body).to include('input field not available')
    expect(response.code).to be 200
  end
end
