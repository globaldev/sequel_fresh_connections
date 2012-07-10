Sequel.require 'connection_pool/threaded'

class Sequel::FreshThreadedConnectionPool < Sequel::ThreadedConnectionPool

  def initialize(opts={})
    super
    @max_connection_age = opts[:max_connection_age] || 1800 # 30 mins
    @last_uses = {}
  end

  def acquire(thread)
    while true
      conn = super
      last_use = @last_uses[conn.object_id]
      connection_age = last_use ? Time.now.to_i - last_use : 0
      break if connection_age <= @max_connection_age
      @disconnection_proc.call(conn) if @disconnection_proc
      @allocated.delete(thread)
      @last_uses.delete(conn.object_id)
    end
    @last_uses[conn.object_id] = Time.now.to_i
    conn
  end

end
