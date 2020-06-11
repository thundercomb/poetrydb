require 'rspec'
require 'spec_helper'

# 200

describe('view home page', {:type => :feature}) do
  it('go to the home page') do
    response = TestHttp.get('/')
    expect(response.body).to include('PoetryDB is the world\'s first API for next generation internet poets')
    expect(response.code).to be 200
  end
end

describe('retrieve random poem', {:type => :feature}) do
  it('go to endpoint for a random poem') do
    response = TestHttp.get('/random')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end
end

describe('retrieve poems by author only', {:type => :feature}) do
  it('go to endpoint for poems by author matching "Dowson"') do
    response = TestHttp.get('/author/Dowson')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end
end

describe('view titles, lines, and author of poems by author as text', {:type => :feature}) do
  it('go to endpoint for poems by author matching "Dowson", and retrieve titles, lines, and author as text') do
    response = TestHttp.get('/author/Dowson/title,lines,author.text')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).to include("title\n")
    expect(response.body).to include("author\n")
    expect(response.body).to include("lines\n")
    expect(response.body).not_to include("linecount\n")
    expect(response.code).to be 200
  end
end

describe('view titles, lines, and author of poems by author as json', {:type => :feature}) do
  it('go to endpoint for poems by author matching "Dowson", and retrieve titles, lines, and author as json') do
    response = TestHttp.get('/author/Dowson/title,lines,author.json')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).not_to include('"linecount":')
    expect(response.code).to be 200
  end
end

describe('view all poems by author', {:type => :feature}) do
  it('go to endpoint for poems by author matching "Dowson", and retrieve all') do
    response = TestHttp.get('/author/Dowson/all')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end
end

describe('view all poems by author as text', {:type => :feature}) do
  it('go to endpoint for poems by author matching "Dowson", and retrieve all as text') do
    response = TestHttp.get('/author/Dowson/all.text')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).to include("title\n")
    expect(response.body).to include("author\n")
    expect(response.body).to include("lines\n")
    expect(response.body).to include("linecount\n")
    expect(response.code).to be 200
  end
end

describe('view all poems by author as json', {:type => :feature}) do
  it('go to endpoint for poems by author matching "Dowson", and retrieve all as json') do
    response = TestHttp.get('/author/Dowson/all.json')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end
end

describe('view title,lines,linecount of poems by author matching a string in the title', {:type => :feature}) do
  it('go to endpoint for poems by author matching "Dowson", matching "Moon" in title, and retrieve titles, lines, and linecount as json') do
    response = TestHttp.get('/author,title/Dowson;Moon/title,lines,linecount')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).to include('"title":')
    expect(response.body).not_to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end
end

describe('view author, linecount of poems by author that contains number of lines', {:type => :feature}) do
  it('go to endpoint for poems by author matching "Dowson", matching "6" lines, and retrieve titles, lines, and linecount as json') do
    response = TestHttp.get('/author,linecount/Dowson;6/title,lines,linecount')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).to include('"title":')
    expect(response.body).not_to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end
end

describe('view author, linecount of poems by author that have specific number of lines', {:type => :feature}) do
  it('go to endpoint for poems by author matching "Dowson", matching exactly "16" lines, and retrieve titles, lines, and linecount as json') do
    response = TestHttp.get('/author,linecount/Dowson;16:abs/title,lines,linecount')
    expect(response.body).to include('Love stays a summer night')
    expect(response.body).to include('"title":')
    expect(response.body).not_to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end
end

describe('view author, title of poems by author and matching title', {:type => :feature}) do
  it('go to endpoint for poems by author matching "Dickinson", matching title "Said Death to Passion", and retrieve all as json') do
    response = TestHttp.get('/author,title/Dickinson;Said%20Death%20to%20Passion')
    expect(response.body).to include('And the Debate was done.')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end
end

describe('view author, title of poems by author and exactly matching title', {:type => :feature}) do
  it('go to endpoint for poems by author matching "Dickinson", matching title "Said Death to Passion" exactly, and retrieve all as json') do
    response = TestHttp.get('/author,title/Dickinson;Said%20Death%20to%20Passion:abs')
    expect(response.body).to include('And the Debate was done.')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end
end

describe('view author, title of poems by exactly matching author and title', {:type => :feature}) do
  it('go to endpoint for poems by author matching "Emily Dickinson" exactly, and matching title "Said Death to Passion" exactly, and retrieve all as json') do
    response = TestHttp.get('/author,title/Emily%20Dickinson:abs;Said%20Death%20to%20Passion:abs')
    expect(response.body).to include('And the Debate was done.')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end
end

describe('provide author and title input fields, exactly matching search terms: author, title, and linecount', {:type => :feature}) do
  it('go to endpoint for poems by author matching "Emily Dickinson" exactly, and matching title "Said Death to Passion" exactly, and retrieve all as json') do
    response = TestHttp.get('/author,title,linecount/Emily%20Dickinson:abs;Said%20Death%20to%20Passion:abs;9:abs')
    expect(response.body).to include('And the Debate was done.')
    expect(response.body).to include('"title":')
    expect(response.body).to include('"author":')
    expect(response.body).to include('"lines":')
    expect(response.body).to include('"linecount":')
    expect(response.code).to be 200
  end
end

# 404

describe('provide search field that matches no poem', {:type => :feature}) do
  it('go to endpoint for poems by Dowson with 6 lines') do
    response = TestHttp.get('/author,linecount/Dowson;6:abs/title,lines,linecount')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('404')
    expect(response.body).to include('Not found')
    expect(response.code).to be 200
  end

  it('go to endpoint for poems by Dickinson with non-existing title "Said" (matched exactly)') do
    response = TestHttp.get('/author,title/Dickinson;Said:abs')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).to include('404')
    expect(response.body).to include('Not found')
    expect(response.code).to be 200
  end

  it('go to endpoint for poems by non-existing author "Dickinson" (matched exactly)') do
    response = TestHttp.get('/author,title/Dickinson:abs;Said%20Death%20to%20Passion:abs')
    expect(response.body).not_to include('And the Debate was done.')
    expect(response.body).to include('404')
    expect(response.body).to include('Not found')
    expect(response.code).to be 200
  end
end

# 405

describe('provide invalid input field', {:type => :feature}) do
  it('go to endpoint for poems using "wrong" as input field') do
    response = TestHttp.get('/wrong')
    expect(response.body).to include('405')
    expect(response.body).to include('list not available. Only author and title allowed.')
    expect(response.code).to be 200
  end

  it('go to endpoint for poems using "wrong" as input field, and valid search field') do
    response = TestHttp.get('/wrong/Dowson/all.text')
    expect(response.body).to include('405')
    expect(response.body).to include('list not available. Only author, title, and linecount allowed.')
    expect(response.code).to be 200
  end

  it('go to endpoint for poems using "wrong" as input field, with valid search field, and "all" output field') do
    response = TestHttp.get('/wrong/Dowson/all.text')
    expect(response.body).to include('405')
    expect(response.body).to include('list not available. Only author, title, and linecount allowed.')
    expect(response.code).to be 200
  end

  it('go to endpoint for poems using "wrong" as input field, with valid search and output fields') do
    response = TestHttp.get('/wrong,linecount/Dowson;16:abs/title,lines,linecount')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('405')
    expect(response.body).to include('list not available. Only author, title, and linecount allowed.')
    expect(response.code).to be 200
  end
end

describe('provide invalid output field', {:type => :feature}) do
  it('retrieve author as type output field "wrong"') do
    response = TestHttp.get('/author/Dowson/title,lines,author.wrong')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('405')
    expect(response.code).to be 200
  end

  it('retrieve all as type output field "wrong"') do
    response = TestHttp.get('/author/Dowson/all.wrong')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('405')
    expect(response.code).to be 200
  end

  it('retrieve poems as invalid output field "titles"') do
    response = TestHttp.get('/author/Dowson/titles')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('405')
    expect(response.code).to be 200
  end

  it('retrieve poems as invalid output field "wrong" and valid "lines"') do
    response = TestHttp.get('/author/Dowson/wrong,lines')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('405')
    expect(response.code).to be 200
  end

  it('retrieve poems as invalid output field "wrong" and valid "lines.text"') do
    response = TestHttp.get('/author/Dowson/wrong,lines.text')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('405')
    expect(response.code).to be 200
  end

  it('retrieve poems as invalid output field "wrong" and invalid "lines.bad"') do
    response = TestHttp.get('/author/Dowson/wrong,lines.bad')
    expect(response.body).not_to include('Love stays a summer night')
    expect(response.body).to include('405')
    expect(response.code).to be 200
  end
end
