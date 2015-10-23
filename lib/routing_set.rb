class RoutingSet
  def routes(method:, path:)
    store.get("#{method}#{path}")
  end

  private

  def store
    @_store ||= Store.new
  end
end
