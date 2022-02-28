# -*- encoding: utf-8 -*-
# stub: cocoapods-hmap-prebuilt 0.0.7 ruby lib

Gem::Specification.new do |s|
  s.name = "cocoapods-hmap-prebuilt".freeze
  s.version = "0.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["EricLou".freeze]
  s.date = "2021-08-06"
  s.description = "A short description of cocoapods-hmap-prebuilt.".freeze
  s.email = ["499304609@qq.com".freeze]
  s.homepage = "http://gitlab.webuy.ai/iOS/cocoapod-hamp-prebuilt.git".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.2".freeze
  s.summary = "A longer description of cocoapods-hmap-prebuilt.".freeze

  s.installed_by_version = "3.1.2" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  s.files = Dir['lib/**/*']
  s.add_development_dependency 'bundler', '~> 2.1'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'rspec', '~> 3.0'

  # if s.respond_to? :add_runtime_dependency then
  #   s.add_development_dependency(%q<bundler>.freeze, ["~> 2.1"])
  #   s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
  #   s.add_development_dependency(%q<rspec>.freeze, ["~> 3.0"])
  # else
  #   s.add_dependency(%q<bundler>.freeze, ["~> 2.1"])
  #   s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
  #   s.add_dependency(%q<rspec>.freeze, ["~> 3.0"])
  # end
end
