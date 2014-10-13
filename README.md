# PoetryDB

## Introduction

PoetryDB is an API for internet poets. <i>But what is an API? </i>

An API ensures that a program (such as a browser) always returns data in an expected format. <i>JSON</i> is one of the most popular formats in use today.

"Why should poets care?" [The answer](http://thecombedthunderclap.blogspot.co.uk/2014/03/kenneth-goldsmith-and-uncreative-writing.html) is blowing in the data winds. Internet technology is making words endlessly manipulable, and traditional poets and writers are getting left behind. I want to change this, by giving us all a leg up into a more empowered future.

<i>How does it work?</i>

You send a URL like [so](http://poetrydb.org/title/Ozymandias/lines.json):

```
http://poetrydb.org/title/Ozymandias/lines.json
```

And hey, presto! out comes the lines of Shelley's famous sonnet:

```
[
  {
    "lines": [
      "I met a traveller from an antique land",
      "Who said: \"Two vast and trunkless legs of stone",
      "Stand in the desert. Near them on the sand,",
      "Half sunk, a shattered visage lies, whose frown",
      "And wrinkled lip and sneer of cold command",
      "Tell that its sculptor well those passions read",
      "Which yet survive, stamped on these lifeless things,",
      "The hand that mocked them and the heart that fed.",
      "And on the pedestal these words appear:",
      "'My name is Ozymandias, King of Kings:",
      "Look on my works, ye mighty, and despair!'",
      "Nothing beside remains. Round the decay",
      "Of that colossal wreck, boundless and bare,",
      "The lone and level sands stretch far away\"."
    ]
  }
]
```

But what do we do with text in json format? The real power of PoetryDB's API becomes apparent when combined with a program. Consider the following Ruby code:

```
require 'httparty'

response = HTTParty.get("http://poetrydb.org/linecount/14/lines").to_a
(0..13).each { |i| puts response[rand(256)]['lines'][i] }
```

This fairly simple code is capable of surprising poetry! The program asks PoetryDB for all poems that are 14 lines in length, then writes out a new sonnet based on the results. Astute readers will know that this is the first step towards creating your own version of Raymond Queneau's [One Hundred Thousand Billion Sonnets] (http://www.growndodo.com/wordplay/oulipo/10%5E14sonnets.html), this time based on some of the most beautiful lines ever written in the English language.

Here is an example:

```
`Now Art has lost its mental charms
Give me now libidinous joys only!
Like a fair lady at her casement, shines
Unlooked for joy in that I honour most.
Transported from my self into your being;
But, Blossom, were I,
What they last thought of when the brain grew sick
  Sits meek Content with light, unanxious heart;
I build my hopes a world above the sky,
Permitted desolations, comfort mine !
He knows the joy. Fools laugh because he reels
That it nor grows with heat, nor drowns with showers.
Beauties of deeper glance, and hear their singing,
Those are my best days, when I shake with feare.
```

## Architecture and code

The API is written in Ruby and uses Sinatra to resolve API routes. The poetry data is stored in a MongoDB database. The Ruby code is provided here as Open Source. The PoetryDB database is not directly accessible, in order to preserve its integrity.

![Architecture Diagram](http://github.com/thundercomb/poetrydb/Architecture_Diagram.png)

## API Reference

<b>General format of API:</b>

```
/<field>/<field data>[:<match type>][/<output field>[,<output field>][..][.<format>]]
```

* ```<field>``` can be one of:

  ```author```: The name, or part of the name, of the author of a poem
  ```title```: The title, or part of the title, of a poem
  ```lines```: Part of a line or lines of a poem
  ```linecount```: The number of lines of a poem, including section headings, but excluding empty lines (eg. section breaks)

* ```<field data>``` relates to ```<field>```. When ```<field>``` is:

  ```author```: ```<field data>``` is the name, or part of the name, of the author of a poem
  ```title```: ```<field data>``` is the title, or part of the title, of a poem
  ```lines```: ```<field data>``` is part of a line or lines of a poem
  ```linecount```: ```<field data>``` is the number of lines of a poem
                   Number of lines includes section headings
                   Number of lines excludes empty lines (eg. section breaks)

* ```[:<match type>]``` is optional. It can be:

  ```:abs```: Match ```<field data>``` exactly when searching ```<field>```

or:

  Default (empty): match ```<field data>``` with any part of ```<field>``` when searching

* ```[/<output field>[,<output field>][..]``` are optional. They are a comma delimited set that can be any combination of:

  Default (empty): Return all data of each of the matching poems
  ```author```: Return only the author of each of the matching poems 
  ```title```: Return only the title of each of the matching poems
  ```lines```: Return only the lines of each of the matching poems
  ```linecount```: Return only the number of lines of each of the matching poems
  ```author,title,...```: Return each output field in the comma delimited list of each of the matching poems

or:

  Default (empty): Return all data of each of the matching poems
  ```all```: Return all data of the matching poems

* [.<format>] is optional. It can be:

  ```.json```: Return data in json format
  ```.text```: Return data in text format

or:

  Default (empty): Return data in json format

### Author

<b>General Format:</b>
```
/author/<author>[:abs][/<output field>,<output field>,..[.<format>]]
```

Format:
```
/author/<author>
```
Example:
```
/author/Ernest Dowson
```
Result:
```
[
  {
    "title": "The Moon Maiden's Song",
    "author": "Ernest Dowson",
    "lines": [
      "Sleep! Cast thy canopy",
      "   Over this sleeper's brain,",
      "Dim grow his memory,",
      "   When he wake again.",
      "",
      "Love stays a summer night,",
      "   Till lights of morning come;",
      "Then takes her winged flight",
      "   Back to her starry home.",
      "",
      "Sleep! Yet thy days are mine;",
      "   Love's seal is over thee:",
      "Far though my ways from thine,",
      "   Dim though thy memory.",
      "",
      "Love stays a summer night,",
      "   Till lights of morning come;",
      "Then takes her winged flight",
      "   Back to her starry home."
    ],
    "linecount": 16
  }
]
```

Format:
```
/author/<author>/author
```
Example:
```
/author/owson/author
```
Result:
```
[
  {
    "author": "Ernest Dowson"
  }
]
```

Format:
```
/author/<author>:abs/author
```
Example:
```
/author/Ernest Dowson:abs/author
```
Result:
```
[
  {
    "author": "Ernest Dowson"
  }
]
```

Format:
```
/author/<author>/<output field>,<output field>,<output field>
```
Example:
```
/author/Ernest Dowson/author,title,linecount
```
Result:
```
[
  {
    "title": "The Moon Maiden's Song",
    "author": "Ernest Dowson",
    "linecount": 16
  }
]
```

Format:
```
/author/<author>/<output field>,<output field>,<output field>.<format>
```
Example:
```
/author/Ernest Dowson/author,title,linecount.text
```
Result:
```
title
The Moon Maiden's Song
author
Ernest Dowson
linecount
16
```

### Title

<b>General Format:</b>
```
/title/<title>[:abs][/<output field>,<output field>,..[.<format>]]
```

Format:
```
/title/<title>
```
Example:
```
/title/Ozymandias
```
Result:
```
[
  {
    "title": "Ozymandias",
    "author": "Percy Bysshe Shelley",
    "lines": [
      "I met a traveller from an antique land",
      "Who said: \"Two vast and trunkless legs of stone",
      "Stand in the desert. Near them on the sand,",
      "Half sunk, a shattered visage lies, whose frown",
      "And wrinkled lip and sneer of cold command",
      "Tell that its sculptor well those passions read",
      "Which yet survive, stamped on these lifeless things,",
      "The hand that mocked them and the heart that fed.",
      "And on the pedestal these words appear:",
      "'My name is Ozymandias, King of Kings:",
      "Look on my works, ye mighty, and despair!'",
      "Nothing beside remains. Round the decay",
      "Of that colossal wreck, boundless and bare,",
      "The lone and level sands stretch far away\"."
    ],
    "linecount": 14
  }
]
```

Format:
```
/title/<title>/title
```
Example:
```
/title/spring/title
```
Result:
```
[
  {
    "title": "I have a Bird in spring"
  },
  {
    "title": "A spring poem from bion"
  },
  {
    "title": "Nay, Lord, not thus! white lilies in the spring,"
  },
  {
    "title": "In spring and summer winds may blow"
  },
  {
    "title": "Sonnet 98: From you have I been absent in the spring"
  }
]
```

Format:
```
/title/<title>:abs/title
```
Example:
```
/title/In spring and summer winds may blow:abs/title
```
Result:
```
[
  {
    "title": "In spring and summer winds may blow"
  }
]
```

Format:
```
/title/<title>/<output field>,<output field>,<output field>
```
Example:
```
/title/Ozymandias/author,title,linecount
```
Result:
```
[
  {
    "title": "Ozymandias",
    "author": "Percy Bysshe Shelley",
    "linecount": 14
  }
]
```

Format:
```
/title/<title>/<output field>,<output field>,<output field>.<format>
```
Example:
```
/title/Ozymandias/title,lines.text
```
Result:
```
title
Ozymandias
lines
I met a traveller from an antique land
Who said: "Two vast and trunkless legs of stone
Stand in the desert. Near them on the sand,
Half sunk, a shattered visage lies, whose frown
And wrinkled lip and sneer of cold command
Tell that its sculptor well those passions read
Which yet survive, stamped on these lifeless things,
The hand that mocked them and the heart that fed.
And on the pedestal these words appear:
'My name is Ozymandias, King of Kings:
Look on my works, ye mighty, and despair!'
Nothing beside remains. Round the decay
Of that colossal wreck, boundless and bare,
The lone and level sands stretch far away".
```

### Lines

<b>General Format:</b>
```
/lines/<lines>[:abs][/<output field>,<output field>,..[.<format>]]
```

Format:
```
/lines/<lines>
```
Example:
```
/lines/Latitudeless Place
```
Result:
```
[
  {
    "title": "Now I knew I lost her --",
    "author": "Emily Dickinson",
    "lines": [
      "Now I knew I lost her --",
      "Not that she was gone --",
      "But Remoteness travelled",
      "On her Face and Tongue.",
      "",
      "Alien, though adjoining",
      "As a Foreign Race --",
      "Traversed she though pausing",
      "Latitudeless Place.",
      "",
      "Elements Unaltered --",
      "Universe the same",
      "But Love's transmigration --",
      "Somehow this had come --",
      "",
      "Henceforth to remember",
      "Nature took the Day",
      "I had paid so much for --",
      "His is Penury",
      "Not who toils for Freedom",
      "Or for Family",
      "But the Restitution",
      "Of Idolatry."
    ],
    "linecount": 20
  }
]
```

Format:
```
/lines/<lines>/<output field>
```
Example:
```
/lines/Latitudeless Place/author
```
Result:
```
[
  {
    "author": "Emily Dickinson"
  }
]
```

Format:
```
/lines/<lines>/<output field>,<output field>,<output field>
```
Example:
```
/lines/Latitudeless Place/author,title,linecount
```
Result:
```
[
  {
    "title": "Now I knew I lost her --",
    "author": "Emily Dickinson",
    "linecount": 20
  }
]
```

Format:
```
/lines/<lines>/<output field>,<output field>,<output field>.<format>
```
Example:
```
/lines/Latitudeless Place/author,title,linecount.text
```
Result:
```
title
Now I knew I lost her --
author
Emily Dickinson
linecount
20
```

### Linecount

<b>General Format:</b>
```
/linecount/<linecount>[/<output field>,<output field>,..[.<format>]]
```

Note: linecount is always exact, and therefore the match type ```:abs``` is not applicable.

Format:
```
/linecount/<linecount>
```
Example:
```
/linecount/3
```
Result:
```
[
  {
    "title": "Of Life to own --",
    "author": "Emily Dickinson",
    "lines": [
      "Of Life to own --",
      "From Life to draw --",
      "But never tough the reservoir --"
    ],
    "linecount": 3
  },
  {
    "title": "A Flower will not trouble her, it has so small a Foot,",
    "author": "Emily Dickinson",
    "lines": [
      "A Flower will not trouble her, it has so small a Foot,",
      "And yet if you compare the Lasts,",
      "Hers is the smallest Boot --"
    ],
    "linecount": 3
  },
  {
    "title": "To see the Summer Sky",
    "author": "Emily Dickinson",
    "lines": [
      "To see the Summer Sky",
      "Is Poetry, though never in a Book it lie --",
      "True Poems flee --"
    ],
    "linecount": 3
  }
]
```

Format:
```
/linecount/<linecount>/<output field>
```
Example:
```
/linecount/3/title
```
Result:
```
[
  {
    "title": "Of Life to own --"
  },
  {
    "title": "A Flower will not trouble her, it has so small a Foot,"
  },
  {
    "title": "To see the Summer Sky"
  }
]
```

Format:
```
/linecount/<linecount>/<output field>,<output field>,<output field>
```
Example:
```
/linecount/51/author,title,linecount
```
Result:
```
[
  {
    "title": "On the Death of the Rev. Dr. Sewell",
    "author": "Phillis Wheatley",
    "linecount": 51
  },
  {
    "title": "A Letter to a Live Poet",
    "author": "Rupert Brooke",
    "linecount": 51
  }
]
```

Format:
```
/linecount/<linecount>/<output field>,<output field>.<format>
```
Example:
```
/linecount/39/author,title.text
```
Result:
```
title
In Winter in my Room
author
Emily Dickinson

title
Celestial Music
author
John Donne

title
Life
author
Robinson

title
29. Song—The Rigs o’ Barley
author
Robert Burns

title
Edinburgh
author
William Topaz McGonagall
```

## Contact

Let me know of any documentation, bugs, or missing features you would like to see, or just come and say hi, on Twitter @po3db 
