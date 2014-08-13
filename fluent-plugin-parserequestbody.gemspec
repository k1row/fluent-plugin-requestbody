# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
#require 'fluent/plugin/parserequestbody/version'

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-parserequestbody"
  spec.version       = "0.0.2"
  spec.authors       = ["Keiichiro Nagashima"]
  spec.email         = ["k16.nagshima@gmail.com"]
  spec.summary       = %q{Fluentd plugin for parse request body}
  spec.description   = %q{Fluentd plugin for parse request body}
  spec.homepage      = "https://github.com/k1row/fluent-plugin-requestbody.git"
  spec.license       = "MIT"

  #spec.files         = `git ls-files -z`.split("\x0")
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_runtime_dependency "fluentd"
end
