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

  it('Search by valid input fields and insufficient corresponding search fields') do
    response = TestHttp.get('/author,title/Dowson')
    expect(response.body).to include('405')
    expect(response.body).to include('Comma delimited fields must have corresponding semicolon delimited search terms')
    expect(response.body).not_to include('"title":')
    expect(response.code).to be 200
  end

  it('Search by valid input fields and insufficient corresponding search fields; return all output fields; format as json') do
    response = TestHttp.get('/author,title/Dowson/all.json')
    expect(response.body).to include('405')
    expect(response.body).to include('Comma delimited fields must have corresponding semicolon delimited search terms')
    expect(response.body).not_to include('"title":')
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

  it('Search by valid input fields and insufficient corresponding search fields; return some output fields; format as json') do
    response = TestHttp.get('/author,title/Dowson/title.json')
    expect(response.body).to include('405')
    expect(response.body).to include('Comma delimited fields must have corresponding semicolon delimited search terms')
    expect(response.body).not_to include('"title":')
    expect(response.code).to be 200
  end

end
