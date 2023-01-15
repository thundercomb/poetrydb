# PoetryDB

## Introduction

PoetryDB is an API for internet poets. <i>But what is an API? </i>

An API ensures that a program (such as a browser) always returns data in an expected format. <i>JSON</i> is one of the most popular formats in use today.

"Why should poets care?" [The answer](https://thecombedthunderclap.blogspot.co.uk/2014/03/kenneth-goldsmith-and-uncreative-writing.html) is blowing in the data winds. Internet technology is making words endlessly manipulable, and traditional poets and writers are getting left behind. I want to change this, by giving us all a leg up into a more empowered future.

<i>How does it work?</i>

You send a URL like [so](https://poetrydb.org/title/Ozymandias/lines.json):

```
https://poetrydb.org/title/Ozymandias/lines.json
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

response = HTTParty.get("https://poetrydb.org/author,linecount/Shakespeare;14/lines").to_a
(0..13).each { |i| puts response[rand(154)]['lines'][i] }
```

This fairly simple code is capable of surprising poetry! The program asks PoetryDB for all poems that are 14 lines in length, then writes out a new sonnet based on the results. Astute readers will know that this is the first step towards creating your own version of Raymond Queneau's [One Hundred Thousand Billion Sonnets](http://www.bevrowe.info/Queneau/QueneauRandom_v5.html), this time based on some of the most beautiful lines ever written in the English language.

Here is an example:

```
Since I left you, mine eye is in my mind;
Full character'd with lasting memory,
The rose looks fair, but fairer we it deem
For that sweet odour, which doth in it live.
Yet, in good faith, some say that thee behold,
Thy face hath not the power to make love groan;
But the defendant doth that plea deny,
By seeing farther than the eye hath shown.
Thou art the grave where buried love doth live,
It is my love that keeps mine eye awake:
Are windows to my breast, where-through the sun
Unless thou take that honour from thy name:
  Therefore I lie with her, and she with me,
  Compar'd with loss of thee, will not seem so.
```

## Architecture and code

The API is written in Ruby and uses Sinatra to resolve API routes. The poetry data is stored in a MongoDB database. The Ruby code is provided here as Open Source. The PoetryDB database is not directly accessible, in order to preserve its integrity.

![Architecture Diagram](https://github.com/thundercomb/poetrydb/blob/master/Architecture_Diagram.jpg)

## API Reference

<b>General format of API:</b>

```
/<input field>/<search term>[;<search term>][..][:<search type>][/<output field>][,<output field>][..][.<format>]
```

* ```<input field>``` can be one of:

  ```author```: The name, or part of the name, of the author of a poem  
  ```title```: The title, or part of the title, of a poem  
  ```lines```: Part of a line or lines of a poem  
  ```linecount```: The number of lines of a poem, including section headings, but excluding empty lines (eg. section breaks)  
  ```poemcount```: The number of poems to return (cannot be used in combination with `random`)
  ```random```: The number of random poems to return (cannot be used in combination with `poemcount`)

* ```<search term>``` relates to ```<input field>```. When ```<input field>``` is:

  ```author```: ```<field data>``` is the name, or part of the name, of the author of a poem  
  ```title```: ```<field data>``` is the title, or part of the title, of a poem  
  ```lines```: ```<field data>``` is part of a line or lines of a poem  
  ```linecount```: ```<field data>``` is the number of lines of a poem. Number of lines includes section headings, but excludes empty lines (eg. section breaks)  
  ```poemcount```: ```<field data>``` is the number of poems to return  
  ```random```: ```<field data>``` is the number of random poems to return

* ```[:<search type>]``` is optional. It can be:

  ```:abs```: Match ```<search term>``` exactly when searching ```<input field>```  
  ```Default (empty)```: match ```<search term>``` with any part of ```<input field>``` when searching  

* ```[/<output field>][,<output field>][..]``` are optional. They are a comma delimited set that can be any combination of:  

  ```author```: Return only the author of each of the matching poems  
  ```title```: Return only the title of each of the matching poems  
  ```lines```: Return only the lines of each of the matching poems  
  ```linecount```: Return only the number of lines of each of the matching poems  
  ```author,title,...```: Return each output field in the comma delimited list of each of the matching poems  
  ```Default (empty)```: Return all data of each of the matching poems  

  or:  

  ```all```: Return all data of the matching poems (same as ```Default (empty)```)  

* ```[.<format>]``` is optional. It can be:  

  ```.json```: Return data in json format  
  ```.text```: Return data in text format  
  ```Default (empty)```: Return data in json format  

* ```[..]``` means that by using the same syntax, more instances of the preceding type can be expressed  

### Author

<b>General Format:</b>
```
/author[/<author>][:abs][/<output field>][,<output field>][..][.<format>]
```

Format:
```
/author
```
Example:
```
/author
```
Result:
```
{
  "authors": [
    "Adam Lindsay Gordon",
    "Alan Seeger",
    "Alexander Pope",
    "Algernon Charles Swinburne",
    .
    .
    "William Shakespeare",
    "William Topaz McGonagall",
    "William Vaughn Moody",
    "William Wordsworth"
  ]
}
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
/title[/<title>][:abs][/<output field>][,<output field>][..][.<format>]
```

Format:
```
/title
```
Example:
```
/title
```
Result:
```
{
  "titles": [
    "A Baby's Death",
    "A Ballad Of The Trees And The Master",
    "A Ballad of Burdens",
    "A Ballad of Death",
    .
    .
    "You know that Portrait in the Moon --",
    "You see I cannot see -- your lifetime",
    "Young Munro the Sailor",
    "Youth And Age"
  ]
}
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
/lines/<lines>[:abs][/<output field>][,<output field>][..][.<format>]
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
/linecount/<linecount>[/<output field>][,<output field>][..][.<format>]
```

Note: linecount is always exact, and therefore the match type ```:abs``` has no effect.

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

### Poemcount

<b>General Format:</b>
```
/<input field>[,<input field>][..],poemcount/<search term>[;<search term][..];<poemcount>[/<output field>][,<output field>][..][.<format>]
```

Notes:
- although poemcount can be provided on its own, it makes sense mainly when combined with other input fields
- poemcount is always exact, and therefore the match type ```:abs``` has no effect
- poemcount and random cannot be used together, as both specify the number of poems to return

Format:
```
/<input field>,poemcount/<search term>;<poemcount>
```
Example:
```
/author,poemcount/Dickinson;2
```
Result:
```
[
  {
    "title": "Not at Home to Callers",
    "author": "Emily Dickinson",
    "lines": [
      "Not at Home to Callers",
      "Says the Naked Tree --",
      "Bonnet due in April --",
      "Wishing you Good Day --"
    ],
    "linecount": "4"
  },
  {
    "title": "Defrauded I a Butterfly --",
    "author": "Emily Dickinson",
    "lines": [
      "Defrauded I a Butterfly --",
      "The lawful Heir -- for Thee --"
    ],
    "linecount": "2"
  }
]
```

Format:
```
/<input field>,poemcount/<search term>;<poemcount>/<output field>
```
Example:
```
/author,poemcount/Dickinson;2/title
```
Result:
```
[
  {
    "title": "Not at Home to Callers"
  },
  {
    "title": "Defrauded I a Butterfly --"
  }
]
```

Format:
```
/<input field>,poemcount/<search term>;<poemcount>/<output field>,<output field>,<output field>
```
Example:
```
/author,poemcount/Dickinson;2/author,title,linecount
```
Result:
```
[
  {
    "title": "Not at Home to Callers",
    "author": "Emily Dickinson",
    "linecount": "4"
  },
  {
    "title": "Defrauded I a Butterfly --",
    "author": "Emily Dickinson",
    "linecount": "2"
  }
]
```

Format:
```
/<input field>,poemcount/<search term>;<poemcount>/<output field>,<output field>.<format>
```
Example:
```
/author,poemcount/Dickinson;2/author,title.text
```
Result:
```
title
Not at Home to Callers
author
Emily Dickinson

title
Defrauded I a Butterfly --
author
Emily Dickinson
```

### Random

<b>General Format:</b>
```
/random[/<random count>][/<output field>][,<output field>][..][.<format>]
```

Note:
- the random count search field is always exact, and therefore the match type ```:abs``` has no effect
- random and poemcount cannot be used together, as both specify the number of poems to return

Format:
```
/random
```
Example:
```
/random
```
Result:
```
[
  {
    "title": "Sonnet XLIV: Press'd by the Moon",
    "author": "Charlotte Smith",
    "lines": [
      "Press'd by the Moon, mute arbitress of tides,",
      "While the loud equinox its power combines,",
      "The sea no more its swelling surge confines,",
      "But o'er the shrinking land sublimely rides.",
      "The wild blast, rising from the Western cave,",
      "Drives the huge billows from their heaving bed;",
      "Tears from their grassy tombs the village dead,",
      "And breaks the silent sabbath of the grave!",
      "With shells and sea-weed mingled, on the shore",
      "Lo! their bones whiten in the frequent wave;",
      "But vain to them the winds and waters rave;",
      "They hear the warring elements no more:",
      "While I am doom'd—by life's long storm opprest,",
      "To gaze with envy on their gloomy rest."
    ],
    "linecount": "14"
  }
]
```

Format:
```
/random/<random count>
```
Example:
```
/random/3
```
Result:
```
[
  {
    "title": "421. Epitaph on a Lap-dog",
    "author": "Robert Burns",
    "lines": [
      "IN wood and wild, ye warbling throng,",
      "  Your heavy loss deplore;",
      "Now, half extinct your powers of song,",
      "  Sweet Echo is no more.",
.
.
.
    ],
    "linecount": "8"
  },
  {
    "title": "The Canterbury Tales. The Manciple's Tale.",
    "author": "Geoffrey Chaucer",
    "lines": [
      "THE PROLOGUE.",
      "",
      "WEET ye not where there stands a little town,",
      "Which that y-called is Bob-up-and-down,",
      "Under the Blee, in Canterbury way?",
      "There gan our Hoste for to jape and play,",
.
.
.
    ],
    "linecount": "364"
  },
  {
    "title": "Love",
    "author": "Percy Bysshe Shelley",
    "lines": [
      "Why is it said thou canst not live",
      "In a youthful breast and fair,",
      "Since thou eternal life canst give,",
      "Canst bloom for ever there?",
.
.
.
  ],
    "linecount": "24"
  }
]
```

Format:
```
/random/<random count>/<output field>
```
Example:
```
/random/3/title
```
Result:
```
[
  {
    "title": "130. Nature’s Law: A Poem"
  },
  {
    "title": "Longings for Home."
  },
  {
    "title": "Buried Life, The"
  }
]
```

Format:
```
/random/<random count>/<output field>,<output field>,<output field>
```
Example:
```
/random/3/author,title,linecount
```
Result:
```
[
  {
    "title": "The Baby's Dance",
    "author": "Ann Taylor",
    "linecount": "8"
  },
  {
    "title": "478. Epigram on a Suicide",
    "author": "Robert Burns",
    "linecount": "4"
  },
  {
    "title": "Reply to Some Verses of J. M. B. Pigot, Esq., on the Cruelty of His Mistress",
    "author": "George Gordon, Lord Byron",
    "linecount": "48"
  }
]
```

Format:
```
/random/<random count>/<output field>,<output field>.<format>
```
Example:
```
/random/3/author,title.text
```
Result:
```
title
Pain In Pleasure
author
Elizabeth Barrett Browning

title
The Heaven vests for Each
author
Emily Dickinson

title
Sonnet XXXIX: Prepare Your Wreaths
author
Robinson
```

### Combinations

<b>General Format:</b>
```
/<input field>,<input field>[,<input field>][..]/<search term>;<search term>[;<search term][..][:abs][/<output field>][,<output field>][..][.<format>]
```

Notes:
1. The number of input fields should always be matched by the number of search terms
2. The search terms are separated by the semicolon to allow commas to be used in search terms. However, semicolons are a feature of many texts, and unfortunately cannot be part of the search term currently.

Format:
```
/<input field>,<input field>/<search term>;<search term>
```
Example:
```
/title,random/Sonnet;3
```
Result:
```
[
  {
    "title": "Sonnet 63: Against my love shall be as I am now",
    "author": "William Shakespeare",
    "lines": [
      "Against my love shall be as I am now,",
      "With Time's injurious hand crush'd and o'erworn;",
      "When hours have drain'd his blood and fill'd his brow",
      "With lines and wrinkles; when his youthful morn",
.
.
.
    ],
    "linecount": "14"
  },
  {
    "title": "Sonnet 69: Those parts of thee that the world's eye doth view",
    "author": "William Shakespeare",
    "lines": [
      "Those parts of thee that the world's eye doth view",
      "Want nothing that the thought of hearts can mend;",
      "All tongues--the voice of souls--give thee that due,",
      "Uttering bare truth, even so as foes commend.",
.
.
.
    ],
    "linecount": "14"
  },
  {
    "title": "Sonnet XVII: His Mother Dear Cupid",
    "author": "Sir Philip Sidney",
    "lines": [
      "His mother dear Cupid offended late,",
      "Because that Mars grown slacker in her love,",
      "With pricking shot he did not throughly more",
      "To keep the pace of their first loving state.",
.
.
.
    ],
    "linecount": "14"
  }
]
```

@@@@
Format:
```
/<input field>,<input field>,<input field>/<search term>;<search term>;<search term>
```
Example:
```
/title,author,linecount/Winter;Shakespeare;18
```
Result:
```
[
  {
    "title": "Spring and Winter ii",
    "author": "William Shakespeare",
    "lines": [
      "WHEN icicles hang by the wall,",
      "   And Dick the shepherd blows his nail,",
      "And Tom bears logs into the hall,",
      "   And milk comes frozen home in pail,",
.
.
.
    ],
    "linecount": 18
  },
  {
    "title": "Spring and Winter i",
    "author": "William Shakespeare",
    "lines": [
      "WHEN daisies pied and violets blue,",
      "   And lady-smocks all silver-white,",
      "And cuckoo-buds of yellow hue",
      "   Do paint the meadows with delight,",
.
.
.
    ],
    "linecount": 18
  },
  {
    "title": "Winter",
    "author": "William Shakespeare",
    "lines": [
      "When icicles hang by the wall",
      "And Dick the shepherd blows his nail",
      "And Tom bears logs into the hall,",
      "And milk comes frozen home in pail,",
.
.
.
    ],
    "linecount": 18
  }
]
```

Format:
```
/<input field>,<input field>/<search term>:abs;<search term>
```

Example:
```
/title,author/Winter:abs;William%20Shakespeare
```
Result:
```
[
  {
    "title": "Winter",
    "author": "William Shakespeare",
    "lines": [
      "When icicles hang by the wall",
      "And Dick the shepherd blows his nail",
      "And Tom bears logs into the hall,",
      "And milk comes frozen home in pail,",
      "When Blood is nipped and ways be foul,",
      "Then nightly sings the staring owl,",
      "Tu-who;",
      "Tu-whit, tu-who: a merry note,",
      "While greasy Joan doth keel the pot.",
      "",
      "When all aloud the wind doth blow,",
      "And coughing drowns the parson's saw,",
      "And birds sit brooding in the snow,",
      "And Marian's nose looks red and raw",
      "When roasted crabs hiss in the bowl,",
      "Then nightly sings the staring owl,",
      "Tu-who;",
      "Tu-whit, tu-who: a merry note,",
      "While greasy Joan doth keel the pot."
    ],
    "linecount": 18
  }
]
```
Format:
```
/<input field>,<input field>,<input field>,<input field>/<search term>;<search term>;<search term>;<search term>
```

Example:
```
/title,author,linecount,poemcount/Winter;William Shakespeare;14;1
```
Result:
```
[
  {
    "title": "Sonnet 2: When forty winters shall besiege thy brow",
    "author": "William Shakespeare",
    "lines": [
      "When forty winters shall besiege thy brow,",
      "And dig deep trenches in thy beauty's field,",
      "Thy youth's proud livery so gazed on now,",
      "Will be a tatter'd weed of small worth held:",
      "Then being asked, where all thy beauty lies,",
      "Where all the treasure of thy lusty days;",
      "To say, within thine own deep sunken eyes,",
      "Were an all-eating shame, and thriftless praise.",
      "How much more praise deserv'd thy beauty's use,",
      "If thou couldst answer 'This fair child of mine",
      "Shall sum my count, and make my old excuse,'",
      "Proving his beauty by succession thine!",
      "  This were to be new made when thou art old,",
      "  And see thy blood warm when thou feel'st it cold."
    ],
    "linecount": "14"
  }
]
```
Format:
```
/<input field>,<input field>/<search term>;<search term>/<output field>
```
Example:
```
/title,author/Winter;William Shakespeare/title
```
Result:
```
[
  {
    "title": "Spring and Winter ii"
  },
  {
    "title": "Spring and Winter i"
  },
  {
    "title": "Blow, Blow, Thou Winter Wind"
  },
  {
    "title": "Winter"
  }
]
```
Format:
```
/<input field>,<input field>/<search term>;<search term>/<output field>[.<format>]
```
Example:
```
/title,author/Winter;William Shakespeare/title.text
```
Result:
```
title
Spring and Winter ii

title
Spring and Winter i

title
Blow, Blow, Thou Winter Wind

title
Winter
```

## Contact

Let me know of any documentation, bugs, or missing features you would like to see, or just come and say hi, on Twitter @po3db

## License

To protect the openness of this endeavour the software is released under the terms of the [GNU Public License v2](https://github.com/thundercomb/poetrydb/blob/master/LICENSE.txt). In essence it allows you to reuse and modify this software, as long as the resulting program(s) remain open and licensed in the same way.
