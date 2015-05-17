Gem::Specification.new do |spec|
  spec.name          = "lita-twilio"
  spec.version       = "0.1.0"
  spec.authors       = ["Chris Woodrich"]
  spec.email         = ["cwoodrich@gmail.com"]
  spec.description   = "Twilio integration for Lita"
  spec.summary       = "Send and receive SMS with from your Lita-configured chat room"
  spec.homepage      = "https://github.com/chriswoodrich/lita-twilio"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.2"
  spec.add_runtime_dependency 'twilio-ruby'


  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
end
