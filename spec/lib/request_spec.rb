require 'spec_helper'

describe Request do
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

  it '#method equal POST' do
    assert { @req.method == 'POST' }
  end

  it '#path equal /hook' do
    assert { @req.path == '/hook' }
  end

  it '#headers equal /coveralls' do
    headers = {
      'User-Agent' => 'curl/7.43.0',
      'Content-Type' => 'application/x-www-form-urlencoded',
      'Accept' => '*/*'
    }

    assert { @req.headers == headers }
  end

  it '#body' do
    assert { @req.body == 'foo=bar&quux=bla' }
  end
end
