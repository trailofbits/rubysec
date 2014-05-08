require 'parslet'

class JSONParser < Parslet::Parser

  rule(:spaces)  { match['\s'].repeat(1) }
  rule(:spaces?) { spaces.maybe }
  rule(:digit)   { match['0-9'] }
  rule(:char)    { match["^\""] }
  rule(:comma)   { spaces? >> str(',') >> spaces? }

  rule(:null)       { }
  rule(:boolean)    { }
  rule(:integer)    { }
  rule(:string)     { }
  rule(:array)      { }
  rule(:hash_table) { }
  rule(:node)       { string | integer | array | hash_table | boolean | null }

  root :array

end
