# Parslet Level 1
In the following workshops we will have you walkthrough building a JSON parser using Parslet. The first level will have you construct the lexical analysis rules for carving the input into tokens. The second level will be concerned with transforming these lexical tokens into Ruby actions. We have provided you with boilerplate code as linked below in the workshop files.

For each of these exercises we have provided Rspec tests for you to check that your implementations are correct, when all of the Rspec tests pass, turn green, then you know you've completed the level! If you are unfamiliar with take a look at
this [Rspec primer](http://blog.davidchelimsky.net/blog/2007/05/14/an-introduction-to-rspec-part-i/).

*While writing out your code, take exceptional care not to introduce vulnerabilities in the transformation process!*

Edit the boiler plate code to create your parser. Once all of the rspec tests pass and all you see is green, move on to level 2.  elow is a listing of the basic Ruby primitives you should be able to parse when finished:

* Null (`null`)
* Boolean (`true`, `false`)
* Integers (`1234`)
* Strings (`"1234"`)
* Arrays (`[1234, "1234"]`)
* Hashes (`{"key": "value"}`)

* [Parser Level 1](/rubysec/parsing1)

## Level 1 Additional Resources

* [Parslet::Parser](http://kschiess.github.io/parslet/parser.html)
* [Parslet Examples](https://github.com/kschiess/parslet/tree/master/example)
* [Parslet Documentation](http://kschiess.github.io/parslet/documentation.html)
* [Parsing with the Parslet Gem](http://www.sitepoint.com/parsing-parslet-gem/)
