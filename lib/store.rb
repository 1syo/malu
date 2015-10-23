require 'validation'
class Store
  extend Forwardable
  def_delegator :conn, :flushdb, :delete_all
  include Validation

  def self.all
    Store.new.all
  end

  def all
    conn.keys.map { |key| [key, get(key)] }
  end

  def add(key, value)
    return false unless ensure_format(key)
    return false unless ensure_url(value)

    conn.sadd(key, value)
  end

  def get(key)
    conn.smembers(key)
  end

  def del(key)
    get(key).all? { |val| conn.srem(key, val) }
  end

  private

  def conn
    @_conn ||= Redis.new
  end
end
