# mongrel2-buildout

Build status: [![Build
Status](https://secure.travis-ci.org/msabramo/mongrel2-buildout.png?branch=master)](https://travis-ci.org/msabramo/mongrel2-buildout)

This repo contains a [buildout][] that creates a simple configuration with
[Mongrel2][] and manages the `mongrel2` process with [procer][].

To give this a spin, try:

    make

That will download and install [Mongrel2][] and [ZeroMQ][] and it will launch
`procer`, which in turn will start `mongrel2` with a very simple configuration.
Then do:

    make test

This will run a short test that tests that Mongrel2 is up and serving a simple
static page correctly at
[http://localhost:6767/tests/](http://localhost:6767/tests/).

[buildout]: http://www.buildout.org/
[Mongrel2]: http://mongrel2.org/
[procer]: http://mongrel2.org/manual/book-finalch5.html#x7-470004.1.1
[ZeroMQ]: http://www.zeromq.org/
