require 'parslet'

class JSONTransformer < Parslet::Transform

  rule(:array => nil)                 { nil             }
  rule(:array => simple(:element))    { [element]       }
  rule(:array => sequence(:elements)) { elements        }
  rule(:array => subtree(:elements))  { Array(elements) }

  rule(:key => simple(:key), :value => subtree(:value)) { [key, value] }

  rule(:hash_table => nil)                       { nil                   }
  rule(:hash_table => sequence(:key_and_value))  { Hash[[key_and_value]] }
  rule(:hash_table => subtree(:keys_and_values)) { Hash[keys_and_values] }

  rule(:null    => simple(:null))    { nil          }
  rule(:boolean => 'true')           { true         }
  rule(:boolean => 'false')          { false        }
  rule(:integer => simple(:integer)) { integer.to_i }
  rule(:string  => nil)              { nil          }
  rule(:string  => simple(:string))  { string.to_s  }

end
