require_relative 'lib/sidekiq_alerts/version'

Gem::Specification.new do |spec|
  spec.name          = "sidekiq_alerts"
  spec.version       = SidekiqAlerts::VERSION
  spec.authors       = ["Danilo Dominguez"]
  spec.email         = ["ddominguez@ubiqua.me"]

  spec.summary       = %q{Provide functionality to generate sentry alerts.}
  spec.description   = %q{Provide functionality to generate sentry alerts in case latency o retry queue surpasses a certain threshold.}
  spec.homepage      = "https://github.com/ubiqua/sidekiq_alerts"
  spec.license       = "Copywrite Ubiqua"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  #spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ubiqua/sidekiq_alerts"
  spec.metadata["changelog_uri"] = "https://github.com/ubiqua/sidekiq_alerts"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.glob("{bin,lib}/**/*") + %w(LICENSE.txt README.md)
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
