# YAML

[YAML](http://www.yaml.org), the once de facto serialization format for Ruby on Rails, now disabled by default due to [CVE-2013-0156]([https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2013-0156), is a superset of JSON.  YAML Supports all of the same regular types that JSON supports, however it also supports the serialization of arbitrary Ruby objects.  This can lead to vulnerabilities when combined with some common Ruby on Rails idions.

Most, if not all, YAML vulnerabiliies arise from the use of some form of Ruby's `eval` function.  As Ruby's Class namespace is global, if there exists some class loaded at the time the YAML parser is running, containing a call to eval, the YAML parser will be able to see and further access, this `eval` usage.  An attacker can then leverage this vulnerability to coerce the parser into making `eval` calls with arbitrary commands.  If this sounds like a bad desing to you, it's because it is, and it's something that every Ruby programmer needs to be *very* aware of.

More specifically, to leverage this vulnerability, an attacker need only instantiate an instance of any class which directly `eval`s on input.  Currently proof of concepts exist throughout the internet for how this is done, but there is relatively little exploit code to be found.  A second methodology is an attacker can instanciate a class which `instance_eval`s input to dynamically define a method, which is a common idiom for Ruby on Rails, and then need only escape out of the method definition.  It is further worth noting that if the dynamic method declaration takes the method name from the input then we can simply inject into the method name, as opposed to the body.

## Pointers

* Find a class which uses some form of `eval` with one of it's fields. Note that you can set all of these fields in YAML, recall the global scope of Ruby classes, so you can pass input to the `eval` call.

* Most of the time the `eval` call is used to dynamically define methods. While there are safer ways to do this, `eval` was used because it's supposedly faster in Ruby 1.8.  To do this you must craft the input to escape out of the method definition,run the desired code, and then start a new method definition so that the input parses correctly.

* Sometimes it's possible to inject code inside the name of a method as opposed to it's body

* If some form of string escaping technique is uesd, try crafting an instance of `Struct` which overrides whatever method name is performing the the escape.

* Often times more complex forms of injection will be necessary.  Don't be afraid to get creative!


## Mitigations

So this is all good and well, but how do we protect against such vulnerabilities?  The simple answer here is to stop using `eval`, [as described here](http://postmodern.github.io/2013/03/07/its-simple-we-kill-eval.html).  Essentially, Ruby blocks are so expressive and fast, that you shouldn't ever need to use `eval`.  While one may consider going to great lengths, jumping through hoops, hashing method names, and escaping method bodies, nothing is as simple or as effective as simply using blocks.  Lastly, note that `instance_eval` and `module_eval` will accept blocks, and you should **always** use blocks as opposed to string interpolation and `eval`.  If you haven't already gotten the hint, use blocks, blocks, and more blocks!


## Some Example Code
```ruby
# Here, Callbacks is a subclass of Hash
# The parser will create an instance of Callbacks with the fields below
--- !ruby/hash:Callbacks
foo: system 'uname -a'

# If String#inspect is being used to escape a string, supply a
# struct instead of a string so that calling #inspect will just
# return what you want it to
# Ruby's duck-typing allows this to occur
--- !ruby/struct
inspect: system 'uname -a'
```



