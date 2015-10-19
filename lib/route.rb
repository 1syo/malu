class Route
  extend Forwardable
  def_delegators :conn, :flushdb, :sadd, :srem

  def get(key)
    result = conn.smembers(key)

    if result == 0
      []
    else
      result
    end
  end

  def sadd_all(key, values)
    values.each { |value| conn.sadd(key, value) }
  end

  def srem_all(key)
    get(key).each { |val| conn.srem(key, val) }
  end

  def list
    conn.keys.map { |key| [key, get(key)] }
  end

  private

  def conn
    @_conn ||= Redis.new
  end
end
