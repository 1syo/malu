require 'spec_helper'

describe Postman do
  before do
    env = Rack::MockRequest.env_for(
      '/hook',
      'REQUEST_METHOD' => 'POST',
      'HTTP_USER_AGENT' => 'curl/7.43.0',
      'HTTP_ACCEPT' => '*/*',
      'CONTENT_TYPE' => 'application/x-www-form-urlencoded',
      :input => 'foo=bar&quux=bla'
    )
    @req = Request.new(env: env)
  end

  it do
    VCR.use_cassette('postman') do
      response = Postman.new(url: 'https://www.example.com', request: @req).post
      assert { response.status == 200 }
    end
  end
end
