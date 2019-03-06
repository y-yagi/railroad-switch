lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "railroad/switch/version"

Gem::Specification.new do |spec|
  spec.name          = "railroad-switch"
  spec.version       = Railroad::Switch::VERSION
  spec.authors       = ["Yuji Yaginuma"]
  spec.email         = ["yuuji.yaginuma@gmail.com"]

  spec.summary       = %q{Switch rack application according to path.}
  spec.homepage      = "https://github.com/y-yagi/railroad-switch"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.4.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "rack-test"
end
