require 'parslet'

class JSONParser < Parslet::Parser

  rule(:spaces)  { match['\s'].repeat(1) }
  rule(:spaces?) { spaces.maybe }
  rule(:digit)   { match['0-9'] }
  rule(:char)    { match["^\""] }
  rule(:comma)   { spaces? >> str(',') >> spaces? }

  rule(:null)    { str('null').as(:null) }
  rule(:boolean) { (str('true') | str('false')).as(:boolean) }
  rule(:integer) { (str('-').maybe >> digit.repeat(1)).as(:integer) }
  rule(:string)  {
    str('"') >> char.repeat.maybe.as(:string) >> str('"')
  }
  rule(:list)    { node >> (comma >> node).repeat }
  rule(:array)   {
    str('[') >> spaces? >> list.maybe.as(:array) >> spaces? >> str(']')
  }
  rule(:hash_list)    {
    string.as(:key) >> str(':') >> spaces? >> node.as(:value) >> (comma >> hash_list).repeat
  }
  rule(:hash_table)    {
    str('{') >> spaces? >> hash_list.maybe.as(:hash_table) >> spaces? >> str('}')
  }
  rule(:node)    { string | integer | array | hash_table | boolean | null }

  root :array

end
