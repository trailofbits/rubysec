# Parslet Level 2

In level 1 you probably noticed that Parslet returns a parse tree, as nested Hashes and Arrays.  Since we are parsing JSON, we want native Ruby Objects not a parse tree. This is where Transforms come in.

Similar to level 1, edit the boiler plate code provided below to create your transformer which will take the tokens you carved in level 1 and interpret them to executable Ruby code.  Once you see all green from the rspec tests you'll have succesfully completed your Parslet Parser and Transformer!

Below is a listing of some examples of converting JSON nodes into their Ruby equivalents:

Your task is to implement a Parslet Transform that converts the JSON nodes into their native Ruby equivalents.

* `{:null=>"null"@}` -> `nil`
* `{:boolean=>"true"@}` -> `true`, `{:boolean=>"false"@}` -> `false`
* `{:integer=>"1234"@}` -> `1234`
* `{:string=>"1234"@}` -> `"1234"`
* `{:array=>[{:integer=>"1234"@},{:string=>"1234"@}]}` -> `[1234, "1234"]`
* `{:hash_table=>[{:key=>{:string=>"key"@}, :value=>{:string=>"value"@}}]}` ->  `{"key"=>"value"}`

But wait, there's more! In order to prevent [CVE-2012-2660], you must also transform any "empty" value into `nil`:

* `""`      -> `nil`
* `[null]`  -> `nil`
* `[""]`    -> `nil`
* `[[]]`    -> `nil`
* `[{}]`    -> `nil`
* `{}`      -> `nil`

## Level 2 Additional Resources

* [Parser Level 2](https://github.com/trailofbits/securitybook/tree/master/ruby_security/parsing2)
* [Parslet::Transform](http://kschiess.github.io/parslet/transform.html)
* [CVE-2012-2660](https://groups.google.com/forum/?fromgroups=#!topic/rubyonrails-security/8SA-M3as7A8)
