require 'sinatra/base'
require 'net/https'
require 'pry'

class Coveralls
  def initialize(env)
    @env = env
  end

  def self.post(env)
    new(env).post
  end

  def post
    ENV['URLS'].split(",").each do |url|
      uri = URI.parse(url.strip)
      req = Net::HTTP::Post.new(uri.path)
      req['Accept'] = '*/*; q=0.5, application/xml'
      req['Accept-Encoding'] = 'gzip, deflate'
      req.body = @env['rack.request.form_vars']
      Net::HTTP.new(uri.host, uri.port).tap do |https|
        https.use_ssl = true
        https.start { https.request(req) }
      end
    end
  end
end


class App < Sinatra::Base
  get '/' do
    ''
  end

  post '/coveralls' do
    Coveralls.post(env)
    'OK'
  end
end
