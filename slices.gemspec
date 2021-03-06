# -*- encoding: utf-8 -*-
require File.expand_path('../lib/slices/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'slices'
  s.version     = Slices::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['With Associates']
  s.email       = ['hello@withassociates.com']
  s.homepage    = 'http://www.withassociates.com'
  s.summary     = 'Slices CMS, from With Associates'
  s.description = 'A Rails 3 CMS that can be embedded within your own site.'

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project         = 'slices'

  s.add_dependency 'bson_ext'          , '~> 1.7.1'
  s.add_dependency 'cocaine'           , '~> 0.3.2'
  s.add_dependency 'devise'            , '~> 1.3.4'
  s.add_dependency 'highline'          , '~> 1.6.0'
  s.add_dependency 'mongo'             , '~> 1.7.1'
  s.add_dependency 'mongoid'           , '~> 2.5.1'
  s.add_dependency 'mongoid-paperclip' , '~> 0.0.8'
  s.add_dependency 'oa-openid'         , '~> 0.3.2'
  s.add_dependency 'paperclip'         , '~> 3.1.4'
  s.add_dependency 'rails'             , '~> 3.2.16'
  s.add_dependency 'redcarpet'         , '~> 3.0.0'
  s.add_dependency 'RedCloth'          , '~> 4.2.9'
  s.add_dependency 'stringex'          , '~> 1.4.0'
  s.add_dependency 'will_paginate'     , '3.0.pre2'

  excluded_files = Dir.glob('app/slices/**/*') + %w(app/views/layouts/default.html.erb)
  s.files        = Dir.glob('{app,lib}/**/*') + %w(CHANGELOG.md README.md Rakefile) - excluded_files
  s.require_path = 'lib'
end
