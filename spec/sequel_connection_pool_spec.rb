require_relative "spec_helper"

# load the fresh_connections extension, then run the sequel connection_pool spec

require "sequel"
$: << File.expand_path("../../lib", __FILE__)
Sequel.extension :fresh_connections

parts = %W{#{Gem.loaded_specs["sequel"].gem_dir} spec core connection_pool_spec}
require File.join(parts)
