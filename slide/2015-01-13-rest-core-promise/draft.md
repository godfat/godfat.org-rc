
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
    - Print the Names
    - Fire and Forget
    - Fire and Call
  * Callbacks / Asynchronous / Non-blocking
    - Fire and Call
    - Fire and Rescue
    - Callback Hell?
    - We Still need Callbacks
  * Wait! It's not yet done
    - `Client#wait`
    - `Client.wait`
  * Promise Chain: `Promise#then`
    - Why: It's Not Blocking Here
    - `RC::Github#all`
  * Promise.claim
    - Forging Response, for middleware `RC::Cache`
- Concurrency Model
  * None / Blocking (For debugging purpose)
  * Thread Spawn (Default)
  * Thread Pool (Throttling)
  * Gotcha!
    - Weird Backtrace for Exceptions
    - Shutting down gracefully
    - Beware of Deadlock!
    - Beware of Timeout!
  * Promise Detail
    - `Promise#defer`
    - `Promise#protected_yield`
    - `Promise#cancel_task`
  * ThreadPool Detail
    - `ThreadPool#defer`
    - `ThreadPool#spawn_worker`
    - `ThreadPool::Task`
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
  * `Thread#raise` is unsafe without `Thread.handle_interrupt`
  * The Timer Thread
    - Single threaded (unlike timeout)
    - Inaccurate
    - Setup Interval
    - Auto-shutdown
