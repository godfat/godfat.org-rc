
# rest-core 的承諾

在 [RubyConf.TW 2011][]，我介紹了 [rest-core][]，是用 Ruby 寫成的模組化 REST
client 組合包與工具組。後來組合包的東西被抽至 [rest-more][]，於是變成給 REST APIs 使用的模組化 Ruby clients interface。

在 [RubyConf.TW 2012][]，我介紹了 Ruby 上的 concurrent 應用程式伺服器。之後在 rest-core 內，加入我從以上所學到的東西，使它能輕易地發出 concurrent requests。

在不同的使用情況下，我們有時候需要使用 promise、有時候需要使用
callback。這次我將介紹該怎麼利用 promise 來達成以我們所熟習的同步風格，發出
concurrent requests；同時也能繼續用 callback 發出非同步的 concurrent requests。

我也會分享所有噁心的實作細節。可能會很複雜，請有心理準備！

# The Promise of rest-core

In [RubyConf.TW 2011][], I talked about *[rest-core][]* as
_A modular Ruby REST client collection/infrastructure_.
Later it's rephrased as _Modular Ruby clients interface for REST APIs_
because the collection was extracted into *[rest-more][]*.

In [RubyConf.TW 2012][], I talked about _Concurrent Ruby Application Servers_.
Later I tried to take what I've learnt from concurrency to make rest-core
better, so that we could easily make concurrent requests for accessing
data via REST APIs.

This time I'll talk about how we take the advantage of *Promise* to make
concurrent requests in an old, synchronous fashion, while still being able to
use callbacks for asynchronous requests concurrently. We need both of promises
and callbacks accordingly.

I'll also talk about all the nasty details about implementing them.
This could be tough, be prepared!

[rest-core]: https://github.com/godfat/rest-core
[rest-more]: https://github.com/godfat/rest-more
[RubyConf.TW 2011]: http://rubyconf.tw/2011/#6
[RubyConf.TW 2012]: http://rubyconf.tw/2012/

# Table of Contents

- Introduction
- The API / Use Cases
  * Futures / Synchronous / Blocking
    - Print the Name
      * client.get('godfat')['name']
    - Print the Names
      * names = [client.get('godfat'), client.get('fatgod')].map{ |r| r['name'] }
      * a, b = client.get('godfat'), client.get('fatgod'); a['name']; b['name']
    - Fire and Forget (without callback)
      * client.post('godfat/message', 'Hi!')
  * Callbacks / Asynchronous / Non-blocking
    - Fire and Forget (with callback)
      * client.post('godfat/messages', 'Hi!'){ |response| }
    - Callback Hell?
      * %w[godfat fatgot].each{ |username| client.get("#{username}/friends"){ |r| client.get("#{r.first['username']}/friends"){ |r| client.post("#{r.first['username']}/messages", 'Hi! Friend of friend.') } }
      * %w[godfat fatgod].each{ |username| client.get("#{username}/friends"){ |r| friends = client.get("#{r.first['username']}/friends"); client.post("#{friends.first['username']}/messages", 'Hi! Friend of friend.') } }
  * Wait! It's not yet done
    - Client#wait
    - Client.wait
    - Tracking WeakRef
  * Promise.claim
  * Promises Chain: Promise#then
    - RC::Github#all
      * Get Repositories -> Get All Pages at once
      * repos = client.get('godfat/repos'); repos[pages].flat_map{ |page| client.get(page) }.inject(&:+)
      * then + future_response
  * Use Whatever API Intuitive to You
- Concurrency Model
  * None / Blocking (For debugging purpose)
    - pool_size = -1
  * Thread Spawn (Default)
    - pool_size = 0
    - Setup Backtrace for Exceptions
  * Thread Pool (Throttling)
    - pool_size > 0
    - Connection Throttle
    - Beware of Deadlock!
    - Beware of Timeout!
    - Auto-scale when all workers are busy (with maximum)
    - Auto-shrinking when a worker is idling (with timeout)
    - Shutting down (along with Client.wait)
- Streaming, the EventSource
  * Server-Sent Events
  * Rack Hijacking
  * Firebase Daemon (rest-firebase)
  * onreconnect Callback
  * Wait! It's not yet done
  * Accept: text/event-stream
  * JavaScript like API
- The Timeout Quest
  * `Thread#kill` is unsafe
  * `Thread#raise` is unsafe without masking
  * The Timer Thread
    - Single threaded (unlike timeout)
    - Inaccurate
    - Setup Interval
    - Auto-shutdown
