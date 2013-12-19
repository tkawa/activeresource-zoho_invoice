# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zoho_invoice_resource/version'

Gem::Specification.new do |spec|
  spec.name          = 'activeresource-zoho_invoice'
  spec.version       = ZohoInvoiceResource::VERSION
  spec.authors       = ['Toru KAWAMURA']
  spec.email         = ['tkawa@4bit.net']
  spec.description   = %q{Zoho Invoice API accessor with ActiveResource}
  spec.summary       = %q{Zoho Invoice API accessor with ActiveResource}
  spec.homepage      = 'https://github.com/tkawa/activeresource-zoho_invoice'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'activeresource', '>= 4.0.0'
  spec.add_dependency 'activerecord'
  spec.add_dependency 'activesupport'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
end
