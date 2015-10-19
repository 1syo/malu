require 'bundler/setup'
ENV['RACK_ENV'] ||= 'development'
Bundler.require(:default, ENV['RACK_ENV'])
require './lib/route'

namespace :route do
  task :environment do
    @key, @val = ENV['KEY'], ENV['VAL']
    @route = Route.new
  end

  desc 'List route'
  task list: :environment do
    @route.list.each do |key, val|
      puts "#{key} #=> [ #{val.join(",\s")} ]"
    end
  end

  desc 'Add new route'
  task add: :environment  do
    @route.sadd(@key, @val)
  end

  desc 'Delete route'
  task del: :environment  do
    @route.srem_all(@key)
  end

  task drop: :environment  do
    @route.flushdb
  end
end

task default: 'route:list'
