
# rest-core 的承諾

在 [RubyConf.TW 2011][]，我分享了 *[rest-core][]*，_一個模組化的 Ruby REST
客戶端組合包與工具組_。後來改稱其為_模組化的 Ruby REST
應用程式客戶端介面_，因為組合包的東西被抽至 *[rest-more][]*。

在 [RubyConf.TW 2012][]，我分享了
_Ruby 的並行應用程式伺服器_。後來我試著把我從並行計算學到的東西，加入
rest-core 使其能夠輕易地發出並行請求，透過 REST 應用程式介面存取資料。

這次我將分享我們怎麼利用*承諾*來達成用我們所熟習的同步風格，發出並行請求；
另一方面又能繼續用回乎發出非同步的並行請求。我們在不同情況下，有時候需要使用承諾，有時候需要使用回乎。

我也將會分享所有噁心的實作細節。可能會很複雜，請有心理準備！

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

Parallel and Concurrent Programming in Haskell:
Chapter 9. Cancellation and Timeouts:
<http://chimera.labs.oreilly.com/books/1230000000929/ch09.html>
