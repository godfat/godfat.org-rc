# Have you seen the Mock Muack yet?

In this talk, I'll briefly introduce what is a test double, and why and when we should use it, and what's the trade of we'll make by using it. WITH GREAT POWER THERE MUST ALSO COME--GREAT RESPONSIBILITY! Examples will all be written with [Muack](https://github.com/godfat/muack).

* Have you seen the Mock Muack yet?
  - Introduction
    - What is a Mock?
    - Why?
    - When?
    - What is a test? To me, it's not a spec, it could be, but the point is, it should help you develop,
      and that's the most important thing. Different people and different projects have different development
      process, therefore they deserve different testing processes.
    - WITH GREAT POWER THERE MUST ALSO COME--GREAT RESPONSIBILITY!
  - Muack
    - What is a Mock?
      - Exactly Match
    - What is a Stub?
      - Pattern Matching
    - What is a Spy? (Mock on Stub)
    - What is a Coat?
    - Proxy mode
    - any_instance_of mode
    - instance_exec mode
    - peek_args
    - peek_return
  - When?
    - Network?
    - Database?
    - Time?
    - Thread?
    - Unit tests (testing implementation?) vs integration tests (testing public API)
    - Modifying Behaviour (lazy tests)
    - Dependency Injection
    - Auto-mocking
  - Cons
    - Thread-unsafe by nature
    - Hiding potential bugs (what if the mocked API was changed?)
  - Extra Topics
    - Muack as a mocky patching library
    - Muack as a development runtime static typing system
    - Why didn't mocks nor stubs check if the injected method exists before?

# FishTank fishtank

* Seafood seafood
  - sequel
* jellyfish
  - rack
* pork
* muack
* rack
