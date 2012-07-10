Sequel.require 'connection_pool/sharded_threaded'

class Sequel::FreshShardedThreadedConnectionPool < Sequel::ShardedThreadedConnectionPool

  def initialize(opts={})
    super
    @max_connection_age = opts[:max_connection_age] || 1800 # 30 mins
    @last_uses = {}
  end

  def acquire(thread, server)
    while true
      conn = super
      last_use = @last_uses[conn.object_id]
      connection_age = last_use ? Time.now.to_i - last_use : 0
      break if connection_age <= @max_connection_age
      sync {remove(thread, conn, server)}
    end
    @last_uses[conn.object_id] = Time.now.to_i
    conn
  end

  def remove(thread, conn, server)
    @last_uses.delete(conn.object_id)
    super
  end

end
