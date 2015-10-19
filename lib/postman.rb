class Postman
  def initialize(url:, request:)
    @url, @_request = url, request
  end

  def post
    conn.post do |request|
      request.headers = @_request.headers
      request.body = @_request.body
    end
  end

  private

  def conn
    @_conn ||= ::Faraday.new(url: @url) do |faraday|
      faraday.response :logger
      faraday.adapter  Faraday.default_adapter
    end
  end
end
