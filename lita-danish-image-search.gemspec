Gem::Specification.new do |spec|
  spec.name          = "lita-danish-image-search"
  spec.version       = "0.1.0"
  spec.authors       = ["danishsarwr"]
  spec.email         = ["danishsarwr@gmail.com"]
  spec.description   = "A lita Image Search bot that returns the Image search results "
  spec.summary       = "Final Project for UCAS SIAT for the course Intelligent Software Engineering"
  spec.homepage      = "https://github.com/danishsarwr/danish-imagesearch.git"
  spec.license       = "Any"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", ">= 4.0"

  spec.add_development_dependency "bundler", ">= 1.3"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "rspec", ">= 3.0.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
end
