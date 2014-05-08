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

class Command < String

  def to_s
    `#{self}`
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

    "Received String: #{data.to_s}"
  end

end

App.run! if $0 == __FILE__
