class Request
  extend Forwardable
  def_delegator :@_request, :path, :path
  def_delegator :@_request, :request_method, :method

  def initialize(env:)
    @_request = Rack::Request.new(env)
  end

  def headers
    {
      'User-Agent' => @_request.user_agent,
      'Content-Type' => @_request.content_type,
      'Accept' => @_request.env['HTTP_ACCEPT']
    }
  end

  def body
    @_body ||= @_request.body.read
  end
end
