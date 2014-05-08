Ronin
================

Welcome to the Ronin exercise! Masterless Samurai rejoice.

In this exercise you will learn how to leverage [Ronin](http://ronin-ruby.github.com/) in order to perform security testing. [Ronin](http://ronin-ruby.github.com/) is actually a fairly large project comprised of many different libraries for writing [Exploits](https://github.com/ronin-ruby/ronin-exploits#readme), [Shellcode](https://github.com/ronin-ruby/ronin-asm#readme), [Scanners](https://github.com/ronin-ruby/ronin-scanners#readme), [Bruteforcers](https://github.com/ronin-ruby/ronin-bruteforcers#readme), etc. For this exercise we will focus on using the [ronin-support](http://ronin-ruby.github.com/docs/ronin-support/frames) library.

###ronin-support

[ronin-support](http://ronin-ruby.github.com/docs/ronin-support/frames) is similar to [activesupport](https://github.com/rails/rails/tree/master/activesupport#readme) of Rails. It provides all the convenience methods and Mixins used in the Ronin Console or for writing [Exploits](https://github.com/ronin-ruby/ronin-exploits#readme). Just using [ronin-support](http://ronin-ruby.github.com/docs/ronin-support/frames) you can quickly write PoC exploits to demonstrate vulnerabilities.

###Additional Resources
Below is a listing of some additional resources to get up to speed on Ronin, or to use as a reference if you are already familiar with the exploitation framework.

* [Ronin](http://ronin-ruby.github.com/)
* [Exploits](https://github.com/ronin-ruby/ronin-exploits#readme)
* [Shellcode](https://github.com/ronin-ruby/ronin-asm#readme)
* [Scanners](https://github.com/ronin-ruby/ronin-scanners#readme)
* [Bruteforcers](https://github.com/ronin-ruby/ronin-bruteforcers#readme)
* [activesupport](https://github.com/rails/rails/tree/master/activesupport#readme)
* [ronin-support](http://ronin-ruby.github.com/docs/ronin-support/frames)

###Challenge

Rewrite one of your YAML exploits using the [ronin-support](http://ronin-ruby.github.com/docs/ronin-support/frames) library. Some boilerplate code already exists in `exploit.rb`.

To test your new exploit, go back to the original YAML exploit and start it's
server:

    $ cd ../yaml/level3/
    $ ./app.rb
    [2013-05-17 18:05:07] INFO  WEBrick 1.3.1
    [2013-05-17 18:05:07] INFO  ruby 1.9.3 (2013-02-22) [x86_64-linux]
    == Sinatra/1.3.5 has taken the stage on 9000 for development with backup from WEBrick
    [2013-05-17 18:05:07] INFO  WEBrick::HTTPServer#start: pid=4037 port=9000

Then draw your sword:

    $ ./exploit.rb "puts 'lol'"
    [-] Exploiting http://localhost:9000/ ...
    [-] Success!

    lol
    Received #<Callbacks: {"REDACTED"=>[true]}>
    localhost.localdomain - - [17/May/2013:18:06:16 PDT] "POST / HTTP/1.1" 200 7
    - -> /

Success indeed.

