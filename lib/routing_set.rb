class RoutingSet
  def initialize(request: nil)
    @key = "#{request.request_method}#{request.path}"
  end

  def match?
    store.exists?(@key)
  end

  def routes
    store.get(@key)
  end

  private

  def store
    @_store ||= Store.new
  end
end
