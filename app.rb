require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'] || :development)

$LOAD_PATH << File.expand_path('../lib', __FILE__)
require 'postman'
require 'request'
require 'routing_set'
require 'store'

class App
  def self.call(env)
    request = Request.new(env: env)

    routing_set = RoutingSet.new
    routing_set.routes(method: request.method, path: request.path).each do |url|
      Postman.new(url: url, request: request).post
    end

    [200, { 'Content-Type' => 'text/plain' }, ['OK']]
  rescue
    [500, { 'Content-Type' => 'text/plain' }, ['ERR']]
  end
end
