# frozen_string_literal: true

require_relative "lib/payday/version"

Gem::Specification.new do |gem|
  gem.name        = "payday"
  gem.version     = Payday::VERSION
  gem.platform    = Gem::Platform::RUBY
  gem.authors     = ["Alan Johnson"]
  gem.email       = ["alan@commondream.net"]
  gem.homepage    = "https://github.com/commondream/payday"
  gem.summary     = "A simple library for rendering invoices."
  gem.description = <<-EOF
    Payday is a library for rendering invoices. At present it supports rendering
    invoices to pdfs, but we're planning on adding support for other formats in
    the near future.
  EOF

  gem.executables   = `git ls-files -- bin/*`.split("\n").map { |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  gem.require_paths = ["lib"]

  gem.add_dependency("prawn", "~> 1.0.0")
  gem.add_dependency("money", "~> 6.5")
  gem.add_dependency("prawn-svg", "~> 0.15.0.0")
  gem.add_dependency("i18n", "~> 0.7")

  gem.add_development_dependency "bundler", "~> 2.0"
end
