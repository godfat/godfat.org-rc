* The Promise of rest-core
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
    * Wait!
      - Client#wait
      - Client.wait
      - Tracking WeakRef
    * Promises Chain
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
    * Thread Pool
      - pool_size > 0
      - Connection Throttle
      - Beware of Deadlock!
      - Beware of Timeout!
      - Auto-scale when all workers are busy (with maximum)
      - Auto-shrinking when a worker is idling (with timeout)
      - Shutting down (along with Client.wait)
  - Streaming, the EventSource
    * Accept: text/event-stream
    * Firebase Daemon (rest-firebase)
    * Auto-reconnect
    * JavaScript like API
    * EventSource#wait
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
