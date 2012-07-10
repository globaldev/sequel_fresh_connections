Sequel.require 'connection_pool/sharded_single'

class Sequel::FreshShardedSingleConnectionPool < Sequel::ShardedSingleConnectionPool

  def initialize(opts={})
    super
    @max_connection_age = opts[:max_connection_age] || 1800 # 30 mins
    @last_uses = {}
  end

  def hold(server=:default)
    begin
      server = pick_server(server)
      conn_age = @last_uses[server] ? Time.now.to_i - @last_uses[server] : 0
      if conn_age > @max_connection_age
        disconnect_server(server, &@disconnection_proc)
      end
      @last_uses[server] = Time.now.to_i
      yield(@conns[server] ||= make_new(server))
    rescue Sequel::DatabaseDisconnectError
      disconnect_server(server, &@disconnection_proc)
      raise
    end
  end

end
