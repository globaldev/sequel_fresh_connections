Sequel.require 'connection_pool/single'

class Sequel::FreshSingleConnectionPool < Sequel::SingleConnectionPool

  def initialize(db, opts={})
    super
    @max_connection_age = opts[:max_connection_age] || 1800 # 30 mins
    @last_use = nil
  end

  def hold(server=nil)
    connection_age = @last_use ? Time.now.to_i - @last_use : 0
    disconnect if connection_age > @max_connection_age
    @last_use = Time.now.to_i
    super
  end

end
