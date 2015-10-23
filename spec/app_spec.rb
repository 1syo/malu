require 'spec_helper'

describe App do
  before do
    @store = Store.new
    @store.add('POST/hook', 'https://www.example.com')
  end

  after do
    @store.delete_all
  end

  it '200 found' do
    env = Rack::MockRequest.env_for(
      '/hook',
      'REQUEST_METHOD' => 'POST',
      'HTTP_USER_AGENT' => 'curl/7.43.0',
      'HTTP_ACCEPT' => '*/*',
      'CONTENT_TYPE' => 'application/x-www-form-urlencoded',
      :input => 'foo=bar&quux=bla'
    )

    VCR.use_cassette('postman') do
      assert { App.call(env).first == 200 }
    end
  end

  it '404 not found' do
    env = Rack::MockRequest.env_for(
      '/hook',
      'REQUEST_METHOD' => 'GET'
    )

    assert { App.call(env).first == 404 }
  end

  it '500 error' do
    assert { App.call(nil).first == 500 }
  end
end
