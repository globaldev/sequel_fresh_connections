require File.expand_path("../../connection_pool/fresh_single", __FILE__)
require File.expand_path("../../connection_pool/fresh_sharded_single", __FILE__)
require File.expand_path("../../connection_pool/fresh_threaded", __FILE__)
require File.expand_path("../../connection_pool/fresh_sharded_threaded", __FILE__)

single_threaded = true
threaded = false
sharded = true
not_sharded = false

map = Sequel::ConnectionPool::CONNECTION_POOL_MAP

map[[single_threaded, not_sharded]] = Sequel::FreshSingleConnectionPool
map[[single_threaded, sharded]] = Sequel::FreshShardedSingleConnectionPool
map[[threaded, not_sharded]] = Sequel::FreshThreadedConnectionPool
map[[threaded, sharded]] = Sequel::FreshShardedThreadedConnectionPool
