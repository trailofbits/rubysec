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
require 'yaml'

class Callbacks < Hash

  def []=(name,code)
    codes = (self[name] || [])
    codes << code

    super(name,codes)

    define_superfast_method(name)
  end

  def define_superfast_method(name)
    code = self[name].join("\n\n")

    instance_eval %{
      def #{name}(*arguments)
        #{code}
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
