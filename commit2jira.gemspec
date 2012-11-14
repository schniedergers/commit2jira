# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'commit2jira'
  s.version     = "0.2.#{ENV['BUILD_NUMBER'] || 'dev'}"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["R. Tyler Croy"]
  s.email       = ["rtyler.croy@lookout.com"]
  s.homepage    = 'https://github.com/lookout/commit2jira'
  s.summary     = %q{a gem for parsing jiras from commits}
  s.description = %q{Herpy derpy}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
