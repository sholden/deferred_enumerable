# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "deferred_enumerable/version"

Gem::Specification.new do |s|
  s.name        = "deferred_enumerable"
  s.version     = DeferredEnumerable::VERSION
  s.authors     = ["Scott Holden"]
  s.email       = ["scott@sshconnection.com"]
  s.homepage    = ""
  s.summary     = %q{Allows deferring execution of enumerable methods}
  s.description = %q{Defer execution of methods such as map by [:a].defer.map(&:to_s)}

  s.rubyforge_project = "deferred_enumerable"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
