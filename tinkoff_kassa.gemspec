lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tinkoff_kassa/version'

Gem::Specification.new do |spec|
  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }

  spec.name          = 'tinkoff_kassa'
  spec.version       = TinkoffKassa::VERSION
  spec.authors       = ['Anton K.']
  spec.email         = ['off.koss@gmail.com']

  spec.summary       = 'Tinkoff Kassa API client'
  spec.description   = 'Ruby client for Tinkoff Kassa API.'
  spec.homepage      = 'https://github.com/kossoff/tinkoff_kassa'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'httparty', '~> 0.14'
end
