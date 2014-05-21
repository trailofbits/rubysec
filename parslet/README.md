Parser
=====
Parsing is a classic (Hard&trade;) computer science problem and a common source of security vulnerabilities.  Specifically, YAML recent had a big problem with this as described in [CVE-2013-0156](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2013-0156). Thus a good question to review is how do parsers work in the first place?  Most parsers take on something similar to the below set of logical steps:

1. Accept a set of rules (and some accompanying actions) and a sequence of tokens.  This step is commonly referred to as the [Lexical Analysis](http://en.wikipedia.org/wiki/Lexical_analysis).
2. Attempt to match a sequence of tokens against a supplied [grammar](http://en.wikipedia.org/wiki/Formal_grammar). Most programming languages can be specified as [Context-Free Grammars](http://en.wikipedia.org/wiki/Context-free_grammar). Nearly all serialization formats are [Regular](http://en.wikipedia.org/wiki/Regular_grammar) or Context-Free Grammars.
3. When the parser encounters a sequence of tokens matching a rule specified in the grammar, it will perform the affiliated action. Generally the goal is to build a tree.

If the above series of steps sounds familiar, it's because this is the common process used for compiling a program.  The goal here is typically to build an [abstract syntax-tree](http://en.wikipedia.org/wiki/Abstract_syntax_tree). If none of this material seems to be making any sense, or you have not had an introductory compilers course, take a look at the 'Additional Resources' section detailed below for some educational material.

## Parslet
[Parslet](http://kschiess.github.io/parslet/) is a pure Ruby library (no compiling!) for constructing lexers/parsers with a clean Ruby DSL. It uses Parsing Expression Grammar (or PEG) which is essentially a Context-Free Grammar with no ambiguity, to perform greedy parsing. Most parsers built on Parslet are built in two stages. First, the input is *parsed* into an intermediate tree (level 1 exercise below) and, second, the input is *transformed* from the intermediary tree into a desired representation (level 2 exercise below).

## Parslet Pointers
More information is detailed in the [Parslet Getting Started doc](http://kschiess.github.io/parslet/get-started.html).

### Parslet::Parser
* Specify rules
  - `rule(name) { definition }`
* Define the root rule:
  - `root :name`
* `str(...)` matches a literal string
* `repeat` is equivalent of `regex*`
* `repeat(1)` is equivalent to `regex+`
* `repeat(1,5)` is equivalent to `regex{1,2}`
* `match(...)` matches data against the specified regular expression
* `match['a-z']` is shorthand for `match('[a-z'])`
* `|` denotes union and `>>` denotes concatenation

### Parslet::Transform
* Specify rules (different meaning here)
  - `rule(pattern) { action }`
* Parslet automatically walks the intermediary tree for you and performs
  `action` whenever it encounters `pattern`
* `simple(:name)` matches a single String value.
* `sequence(:name)` matches an Array of String values.
* `subtree(:name)` matches a Hash within the Parslet tree.

## Workshop: JSON Parsing
In the following workshops we will have you walkthrough building a JSON parser using Parslet. The first level will have you construct the lexical analysis rules for carving the input into tokens. The second level will be concerned with transforming these lexical tokens into Ruby actions. We have provided you with boilerplate code as linked below in the workshop files.

For each of these exercises we have provided Rspec tests for you to check that your implementations are correct, when all of the Rspec tests pass, turn green, then you know you've completed the level! If you are unfamiliar with take a look at
this [Rspec primer](http://blog.davidchelimsky.net/blog/2007/05/14/an-introduction-to-rspec-part-i/).

*While writing out your code, take exceptional care not to introduce vulnerabilities in the transformation process!*

## Additional Resources
* [WikiBooks Compiler Construction/Introduction](http://en.wikibooks.org/wiki/Compiler_Construction/Introduction)
* [Parslet](http://kschiess.github.com/parslet/)
* [Parsing Expression Grammar, or PEG](http://en.wikipedia.org/wiki/Parsing_expression_grammar)
* [RFC 4627 - JSON Parsing](http://www.ietf.org/rfc/rfc4627.txt)
* [JSON](http://www.json.org/)
