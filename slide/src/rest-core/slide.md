
# [rest-core][]<br/><span style="font-size:60%">A modular Ruby REST client collection/infrastructure</span>

[rest-core]: https://github.com/cardinalblue/rest-core

---

# [http://godfat.org/slide<br/>/2011-08-27-rest-core.html](http://godfat.org/slide/2011-08-27-rest-core.html)

---

# ![avatar](image/spiritual_soul.jpg) Lin Jen-Shin ([godfat][])

<br/>

---

# ![avatar](image/spiritual_soul.jpg) Lin Jen-Shin ([godfat][])

<br/>

* Programmer at [Cardinal Blue][]

---

# ![avatar](image/spiritual_soul.jpg) Lin Jen-Shin ([godfat][])

<br/>

* Programmer at [Cardinal Blue][]
* Programming Language

---

# ![avatar](image/spiritual_soul.jpg) Lin Jen-Shin ([godfat][])

<br/>

* Programmer at [Cardinal Blue][]
* Programming Language
* Functional Programming (Haskell)

---

# ![avatar](image/spiritual_soul.jpg) Lin Jen-Shin ([godfat][])

<br/>

* Programmer at [Cardinal Blue][]
* Programming Language
* Functional Programming (Haskell)
* Ruby

[godfat]: http://godfat.org/
[Cardinal Blue]: http://cardinalblue.com/

---

<br/>

* rest-graph

---

<br/>

* rest-graph
* Quick Example

---

<br/>

* rest-graph
* Quick Example
* Rack

---

<br/>

* rest-graph
* Quick Example
* Rack
* Architecture

---

# [rest-graph][]<br/><span style="font-size:60%">A lightweight Facebook Graph API client</span>

[rest-graph]: https://github.com/cardinalblue/rest-graph

---

<br/>

* [Tribute Balloon][]

---

<br/>

* [Tribute Balloon][]
* [Friend Stock 2][]

---

<br/>

* [Tribute Balloon][]
* [Friend Stock 2][]
* [Friend Stock Market][]

---

# ![facebook](image/Facebook-Logo.png)

---

<br/>

* [Tribute Balloon][]
* [Friend Stock 2][]
* [Friend Stock Market][]
* [Pic Collage][]

[Tribute Balloon]: http://tributeballoon.com/
[Friend Stock 2]: http://friendstock.org
[Friend Stock Market]: http://friendmkt.com/
[Pic Collage]: http://pic-collage.com/

---

# ![web-services](diagram/web-services.png)

---

# Solution: [rest-core][]

---

# Inspired by [faraday][] and [Rack][]

[faraday]: https://github.com/technoweenie/faraday
[Rack]: https://github.com/rack/rack

---

<br/>

* rest-graph
* <span style="color: #800">__Quick Example__</span>
* Rack
* Architecture

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
      client = Github.new
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
      client = Github.new
      client.get('godfat') # slow
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
      client = Github.new
      client.get('godfat') # slow
      client.get('godfat') # cache hit
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
      client = Github.new
      client.get('godfat') # slow
      client.get('godfat') # cache hit
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
      ♨
      client = Github.new
      client.get('godfat') # slow
      client.get('godfat') # cache hit
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
        ♨
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
        use CommonLogger, method(:puts)
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
        use CommonLogger, method(:puts)
        use Cache       , {}, 3600
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
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        use CommonLogger, method(:puts)
        use Cache       , {}, 3600
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
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        use CommonLogger, method(:puts)
        use Cache       , {}, 3600
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
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        use CommonLogger, method(:puts)
        use Cache       , {}, 3600
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
      ♨

---

    !ruby

      Github = RestCore::Builder.client do
        use DefaultSite , 'https://api.github.com/users/'
        use JsonDecode  , true
        use CommonLogger, method(:puts)
        use Cache       , {}, 3600
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
      ♨

---

<br/>

* rest-graph
* Quick Example
* <span style="color: #800">__Rack__</span>
* Architecture

---

# ![rack](image/rack-logo.png)

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

<br/><br/>

    !ruby

      ♨
                    use Doo
      ♨
      ♨
      ♨
      ♨

---

<br/><br/>

    !ruby

      ♨
                    use Doo
                    use Coo
      ♨
      ♨
      ♨

---

<br/><br/>

    !ruby

      ♨
                    use Doo
                    use Coo
                    use Boo
      ♨
      ♨

---

<br/><br/>

    !ruby

      ♨
                    use Doo
                    use Coo
                    use Boo
                    run App
      ♨

---

<br/><br/>

    !ruby

                  Rack::Builder.new do
                    use Doo
                    use Coo
                    use Boo
                    run App
                  end

---

![app](diagram/10-app.png)

    !ruby

                              App

---

![app-mid](diagram/11-app-mid.png)

    !ruby

                      Boo.new(App)

---

![app-mid-mid](diagram/12-app-mid-mid.png)

    !ruby

              Coo.new(Boo.new(App))

---

![app-mid-mid-mid](diagram/13-app-mid-mid-mid.png)

    !ruby

      Doo.new(Coo.new(Boo.new(App)))

---

![app-mid-mid-mid-arrow](diagram/14-app-mid-mid-mid-arrow.png)

    !haskell

      Doo.new(Coo.new(Boo.new(App)))

---

# Composable and Reusable

---

# Rack is for building servers

---

# Why not do the same for clients?

---

<br/>

* rest-graph
* Quick Example
* Rack
* <span style="color: #800">__Architecture__</span>

---

<span style="position:absolute;left:360px;top:300px;font-size:70%">(Web Application)</span>

![client-server](diagram/00-client-server.png)

<span style="position:absolute;left:247px;top:540px;font-size:55%">(Firefox)</span>
<span style="position:absolute;left:430px;top:540px;font-size:55%">(Chrome)</span>
<span style="position:absolute;left:623px;top:540px;font-size:55%">(Opera)</span>

---

<span style="position:absolute;left:360px;top:300px;font-size:70%">(Web Application)</span>

![server-client](diagram/01-server-client.png)

<span style="position:absolute;left:247px;top:540px;font-size:55%">(Twitter)</span>
<span style="position:absolute;left:435px;top:540px;font-size:55%">(Github)</span>
<span style="position:absolute;left:608px;top:540px;font-size:55%">(Facebook)</span>

---

![rack](diagram/rack.png)

---

![middleware-large](diagram/08-middleware-large.png)

---

![middleware-large](diagram/08-middleware-large.png)

<span style="position:absolute;left:230px;top:140px">DefaultSite</span>

---

![middleware-large](diagram/08-middleware-large.png)

<span style="position:absolute;left:230px;top:140px">DefaultSite</span>
<span style="position:absolute;left:500px;top:220px">JsonDecode</span>

---

![middleware-large](diagram/08-middleware-large.png)

<span style="position:absolute;left:230px;top:140px">DefaultSite</span>
<span style="position:absolute;left:500px;top:220px">JsonDecode</span>
<span style="position:absolute;left:330px;top:360px">CommonLogger</span>

---

![middleware-large](diagram/08-middleware-large.png)

<span style="position:absolute;left:230px;top:140px">DefaultSite</span>
<span style="position:absolute;left:500px;top:220px">JsonDecode</span>
<span style="position:absolute;left:330px;top:360px">CommonLogger</span>
<span style="position:absolute;left:420px;top:460px">Cache</span>

---

![middleware-large](diagram/08-middleware-large.png)

<span style="position:absolute;left:230px;top:140px">DefaultSite</span>
<span style="position:absolute;left:500px;top:220px">JsonDecode</span>
<span style="position:absolute;left:330px;top:360px">CommonLogger</span>
<span style="position:absolute;left:420px;top:460px">Cache</span>
<span style="position:absolute;left:387px;top:590px;color:#800">RestClient</span>

---

![multiple-clients](diagram/03-multiple-clients.png)

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
      restgraph = RestGraph.new # Facebook Graph API
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
      restgraph = RestGraph.new # Facebook Graph API
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
      restgraph = RestGraph.new # Facebook Graph API
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
      restgraph = RestGraph.new # Facebook Graph API
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
      restgraph = RestGraph.new # Facebook Graph API
      ♨
      github.get('godfat')
      twitter.get('user_timeline.json', :id => 'godfat')
      linkedin.get('v1/people/~') # need authorize first
      restgraph.get('spellbook')

---

# But actually clients are more complex...

---

![more-clients](diagram/04-more-clients.png)

---

    !ruby

      common = RestGraph.new                # Facebook Graph API
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      common = RestGraph.new(:timeout => 2) # Facebook Graph API
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      common = RestGraph.new(:timeout => 2) # Facebook Graph API
      common.get('spellbook')
      ♨
      ♨
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      common = RestGraph.new(:timeout => 2) # Facebook Graph API
      common.get('spellbook')
      ♨
      upload = RestGraph.new(:timeout => 10)
      ♨
      ♨
      ♨
      ♨

---

    !ruby

      common = RestGraph.new(:timeout => 2) # Facebook Graph API
      common.get('spellbook')
      ♨
      upload = RestGraph.new(:timeout => 10)
      upload.post('4/photos', :source => File.open('...'))
      ♨
      ♨
      ♨

---

    !ruby

      common = RestGraph.new(:timeout => 2) # Facebook Graph API
      common.get('spellbook')
      ♨
      upload = RestGraph.new(:timeout => 10)
      upload.post('4/photos', :source => File.open('...'))
      ♨
      common.get('spellbook', {}, :timeout => 10)
      ♨

---

    !ruby

      common = RestGraph.new(:timeout => 2) # Facebook Graph API
      common.get('spellbook')
      ♨
      upload = RestGraph.new(:timeout => 10)
      upload.post('4/photos', :source => File.open('...'))
      ♨
      common.get('spellbook', {}, :timeout => 10)
      common.get('spellbook') # still timeout 2

---

# Tools used to build this slide

* [Landslide][] to make this slide
* [Pygments][] to do syntax highlighting
* Adobe Illustrator to draw diagrams
* TextMate to edit markdown
* [Nokogiri][] to fix generated HTML
* [Rib][] to interactively find out how to fix HTML
* [Firefox][] to view HTML

[Landslide]: https://raw.github.com/adamzap/landslide
[Pygments]: http://pygments.org/
[Nokogiri]: https://github.com/tenderlove/nokogiri
[Rib]: https://github.com/godfat/rib
[Firefox]: http://www.mozilla.com/

---

# Feel free to contact me

* <https://github.com/godfat>
* <https://twitter.com/godfat>

---

# Feel free to contact me

* <https://github.com/godfat>
* <https://twitter.com/godfat>

# We are hiring

* <http://cardinalblue.com/jobs>

---

# Feel free to contact me

* <https://github.com/godfat>
* <https://twitter.com/godfat>

# We are hiring

* <http://cardinalblue.com/jobs>

# This slide is located at

* <span style="font-size: 70%"><http://godfat.org/slide/2011-08-27-rest-core.html></span>

<span style="position:relative; left:220px; top:-550px; font-size:450px; opacity:0.5">Q?</span>
