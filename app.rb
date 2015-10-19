require 'bundler/setup'
Bundler.require(:default, ENV['RACK_ENV'])

$LOAD_PATH << File.expand_path('../lib', __FILE__)
require 'postman'
require 'request'
require 'route'

class App
  def self.call(env)
    request = Request.new(env: env)

    Route.new.get(request.path_info).each do |url|
      Postman.new(url: url, request: request).post
    end

    [200, {'Content-Type' => 'text/plain'}, ['OK']]
  end
end
