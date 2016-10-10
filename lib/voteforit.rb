require 'sinatra'
require 'voteforit/version'
require 'redis'
require 'yaml'
require 'yaml/store'

module Voteforit
  class Server < Sinatra::Base
    set :root, File.dirname(File.dirname(__FILE__))

    configure do
      set :redis, Redis.new(url: config.fetch("redis_url"))
      begin
        redis.ping
      rescue Redis::CannotConnectError => e
        abort "Cannot connect to Redis #{config.fetch("redis_url")} (#{e.inspect})"
      end
    end

    helpers do
      def key_for(key)
        "voteforit.choices.#{key}"
      end
    end

    get '/' do
      @title = 'Welcome to the Voting App'
      erb :index
    end

    post '/cast' do
      @title = 'Thanks for casting your vote!'
      @vote = params['vote']
      settings.redis.incr(key_for(@vote))
      erb :cast
    end

    get '/results' do
      @title = 'Results so far:'
      @votes = {}
      settings.choices.keys.each do |key|
        @votes[key] = settings.redis.get(key_for(key))
      end
      erb :results
    end
  end
end
