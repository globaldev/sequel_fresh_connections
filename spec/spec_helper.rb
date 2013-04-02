require "simplecov"
SimpleCov.start do
  add_filter "spec"
  add_filter "vendor"
  add_filter ".bundle"
end
