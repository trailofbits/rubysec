#!/usr/bin/env ruby

require 'rubygems'

begin
  require 'bundler/setup'
rescue LoadError => e
  warn e.message
  warn "Run `gem install bundler` to install Bundler"
  exit -1
end

require 'sinatra/base'
require 'digest/md5'
require 'yaml'

class Callbacks < Hash

  def []=(name,code)
    codes = (self[name] || [])
    codes << code

    super(name,codes)

    define_fast_and_safest_method(name)
  end

  def define_fast_and_safest_method(name)
    # escape the method-name using an MD5 checksum. Take that evil hackers!
    method_name = "callback_#{Digest::MD5.hexdigest(name)}"

    # eval the escaped String-form of the code (ex: `eval("1 + 1")`)
    method_body = self[name].map { |code|
      "eval(#{code.inspect})"
    }.join("\n")

    instance_eval %{
      def #{method_name}(*arguments)
        #{method_body}
      end
    }
  end

end

class App < Sinatra::Base

  set :bind, 'localhost'
  set :port, 9000

  get '/' do
    erb :index
  end

  post '/' do
    data = YAML.load(request.params['data'])

    puts "Received #<#{data.class}: #{data.inspect}>"

    'Success'
  end

end

App.run! if $0 == __FILE__
