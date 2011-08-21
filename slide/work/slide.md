
# rest-core<br/><span style="font-size:60%">A modular Ruby REST client collection/infrastructure<br/></span>

---

# [http://godfat.org/slide<br/>/2011-08-27-rest-core.html](http://godfat.org/slide/2011-08-27-rest-core.html)

---

# ![avatar](image/spiritual_soul.jpg) Lin Jen-Shin ([godfat][])

<br/>

* Programmer at [Cardinal Blue][]
* Programming Language
* Functional Programming (Haskell)
* Ruby

[Cardinal Blue]: http://cardinalblue.com/
[godfat]: http://godfat.org/

---

<br/>

* Web API
* Web Application as servers
* Web Application as clients

---

![web-services](diagram/web-services.png)

---

![tools](diagram/tools.png)

---

# [![soapbox](image/soapbox.jpg)][soapbox]

[soapbox]: http://www.quixoticpixels.com/blog/2011/06/soap-box/

---

# <span style="color:white; position:relative; top:150px; left:158px ">REST</span><br/>![rest](image/couch_db.jpg)

---

# Solution: [rest-core][]

[rest-core]: https://github.com/cardinalblue/rest-core

---

    !ruby

      Github = RestCore::Builder.client do
      end

---

    !ruby

      Github = RestCore::Builder.client do
      ♨
      ♨
      ♨
      end
      ♨
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
      ♨
      ♨
      end
      ♨
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
      ♨
      end
      ♨
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        run RestClient
      end
      ♨
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        run RestClient
      end
      ♨
      Github.new.get('godfat')

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        run RestClient
      end
      ♨
      Github.new.get('godfat')
      ♨
      {"type"=>"User","company"=>"cardinalblue",
       "blog"=>"http://godfat.org","hireable"=>false,
       "url"=>"https://api.github.com/users/godfat",
       "followers"=>40,"html_url"=>"https://github.com/godfat",
       "bio"=>nil,"created_at"=>"2008-05-15T18:33:24Z",
       "avatar_url"=>"https://...","following"=>33,
       "name"=>"Lin Jen-Shin (godfat)","location"=>"Taiwan",
       "email"=>"godfat (XD) godfat.org","public_repos"=>62,
       "id"=>10416,"login"=>"godfat","public_gists"=>59}

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        ♨
        run RestClient
      end
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        use Cache       , {}, 3600
        run RestClient
      end
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        use Cache       , {}, 3600
        run RestClient
      end

      client = Github.new
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        use Cache       , {}, 3600
        run RestClient
      end

      client = Github.new
      client.get('godfat') # slow
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        use Cache       , {}, 3600
        run RestClient
      end

      client = Github.new
      client.get('godfat') # slow
      client.get('godfat') # cache hit
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        use Cache       , {}, 3600
        run RestClient
      end

      client = Github.new
      client.get('godfat') # slow
      client.get('godfat') # cache hit
      client.get('godfat') # cache hit
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        use Cache       , {}, 3600
        run RestClient
      end

      client = Github.new
      client.get('godfat') # slow
      client.get('godfat') # cache hit
      client.get('godfat') # cache hit
      client.get('godfat') # cache hit
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        ♨
        use Cache       , {}, nil
        run RestClient
      end
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        use CommonLogger, method(:puts)
        use Cache       , {}, nil
        run RestClient
      end
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        use CommonLogger, method(:puts)
        use Cache       , {}, nil
        run RestClient
      end
      ♨
      client = Github.new
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        use CommonLogger, method(:puts)
        use Cache       , {}, nil
        run RestClient
      end
      ♨
      client = Github.new
      client.get('godfat') # slow
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        use CommonLogger, method(:puts)
        use Cache       , {}, nil
        run RestClient
      end
      ♨
      client = Github.new
      client.get('godfat') # slow
      # RestCore: spent 1.498819 Requested https://api.github.com/users/godfat
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        use CommonLogger, method(:puts)
        use Cache       , {}, nil
        run RestClient
      end
      ♨
      client = Github.new
      client.get('godfat') # slow
      # RestCore: spent 1.498819 Requested https://api.github.com/users/godfat
      client.get('godfat') # cache hit
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        use CommonLogger, method(:puts)
        use Cache       , {}, nil
        run RestClient
      end
      ♨
      client = Github.new
      client.get('godfat') # slow
      # RestCore: spent 1.498819 Requested https://api.github.com/users/godfat
      client.get('godfat') # cache hit
      # RestCore: spent 2.0e-05 CacheHit https://api.github.com/users/godfat
      # RestCore: spent 6.9e-05 Requested https://api.github.com/users/godfat
      ♨
      ♨

---

# Web Application as servers

---

![client-server](diagram/00-client-server.png)

---

![server-client](diagram/01-server-client.png)

---

# Web Application as clients

---

# The History

---

# CGI (Common Gateway Interface)

---

# FastCGI

---

# SCGI (Simple CGI)

---

# Mongrel

---

# Rack (from WSGI)

---

<br/><br/><br/><br/><br/>![rack](image/rack-logo.png)

---

* [WSGI][] (Python)
* [Rack][] (Ruby)
* [PSGI][] and [Plack][] (Perl)
* [Hack2][] / [WAI][] (Haskell)
* [JSGI & Jack][] (JavaScript)
* [Ring][] (Clojure)
* [EWGI][] (Erlang)
* [PHP Rack][] (PHP)

[WSGI]: http://wsgi.org/
[Rack]: http://github.com/rack/rack
[PSGI]: http://github.com/miyagawa/psgi-specs
[Plack]: http://github.com/miyagawa/Plack
[Hack2]: http://github.com/nfjinjing/hack2
[WAI]: https://github.com/yesodweb/wai
[JSGI & Jack]: https://github.com/tlrobinson/jack
[Ring]: http://github.com/mmcgrana/ring
[EWGI]: http://github.com/skarab/ewgi
[PHP Rack]: http://github.com/jimeh/php-rack

---

<br/><br/><br/>

    !haskell

      ♨
      (middleware (middleware (middleware app)))
      ♨

---

<br/><br/><br/>

    !haskell

      -- --> --> --> --> --> --> --> --> --> -->
      (middleware (middleware (middleware app)))
      -- <-- <-- <-- <-- <-- <-- <-- <-- <-- <--

---

# Composable and Reusable

---

# Why not do the same for<br/>Web Application as clients?

---

![client-server](diagram/00-client-server.png)

---

![server-client](diagram/01-server-client.png)

---

![multiple-clients](diagram/02-multiple-clients.png)

---

    !ruby

      github = Github.new
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      github = Github.new
      twitter = Twitter.new
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      github = Github.new
      twitter = Twitter.new
      linkedin = Linkedin.new
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      github = Github.new
      twitter = Twitter.new
      linkedin = Linkedin.new
      restgraph = RestGraph.new
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      github = Github.new
      twitter = Twitter.new
      linkedin = Linkedin.new
      restgraph = RestGraph.new
      ♨
      github.get('godfat')
      ♨
      ♨
      ♨

---

    !ruby

      github = Github.new
      twitter = Twitter.new
      linkedin = Linkedin.new
      restgraph = RestGraph.new
      ♨
      github.get('godfat')
      twitter.get('user_timeline.json', :id => 'godfat')
      ♨
      ♨

---

    !ruby

      github = Github.new
      twitter = Twitter.new
      linkedin = Linkedin.new
      restgraph = RestGraph.new
      ♨
      github.get('godfat')
      twitter.get('user_timeline.json', :id => 'godfat')
      linkedin.get('v1/people/~') # need authorize first
      ♨

---

    !ruby

      github = Github.new
      twitter = Twitter.new
      linkedin = Linkedin.new
      restgraph = RestGraph.new
      ♨
      github.get('godfat')
      twitter.get('user_timeline.json', :id => 'godfat')
      linkedin.get('v1/people/~') # need authorize first
      restgraph.get('spellbook')

---

![multiple-clients](diagram/02-multiple-clients.png)

---

![multiple-clients](diagram/03-multiple-clients.png)

---

![more-clients](diagram/04-more-clients.png)

---

    !ruby

      common = RestGraph.new
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      common = RestGraph.new(:timeout => 2)
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      common = RestGraph.new(:timeout => 2)
      common.get('spellbook')
      ♨
      ♨
      ♨

---

    !ruby

      common = RestGraph.new(:timeout => 2)
      common.get('spellbook')
      ♨
      upload = RestGraph.new(:timeout => 10)
      ♨

---

    !ruby

      common = RestGraph.new(:timeout => 2)
      common.get('spellbook')
      ♨
      upload = RestGraph.new(:timeout => 10)
      upload.post('4/photos', :source => File.open('...'))

---

![stack](diagram/05-stack.png)

---

![middlewares](diagram/06-middlewares.png)

---

# Tools I used

* [landslide][] to make this slide
* [pygments][] to do syntax highlighting
* [nokogiri][] to fix generated html
* [rib][] to interactively find out how to fix html
* [firefox][] to view html

[landslide]: https://raw.github.com/adamzap/landslide
[pygments]: http://pygments.org/
[nokogiri]: https://github.com/tenderlove/nokogiri
[rib]: https://github.com/godfat/rib
[firefox]: http://www.mozilla.com/

---

# Feel free to contact me

* <https://github.com/godfat>
* <https://twitter.com/godfat>

## This slide is located at

* <span style="font-size: 70%"><http://godfat.org/slide/2011-08-27-rest-core.html></span>
