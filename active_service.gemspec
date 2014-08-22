# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: active_service 1.0.0 ruby lib

Gem::Specification.new do |s|
  s.name = "active_service"
  s.version = "1.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["zwelchcb"]
  s.date = "2014-08-22"
  s.description = "ActiveService is an ORM that maps REST resources to Ruby objects using an ActiveRecord-like interface."
  s.email = "Zachary.Welch@careerbuilder.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "active_service.gemspec",
    "lib/active_service.rb",
    "lib/active_service/api.rb",
    "lib/active_service/base.rb",
    "lib/active_service/collection.rb",
    "lib/active_service/errors.rb",
    "lib/active_service/middleware.rb",
    "lib/active_service/middleware/parse_json.rb",
    "lib/active_service/model.rb",
    "lib/active_service/model/associations.rb",
    "lib/active_service/model/associations/association.rb",
    "lib/active_service/model/associations/association_proxy.rb",
    "lib/active_service/model/associations/belongs_to_association.rb",
    "lib/active_service/model/associations/has_many_association.rb",
    "lib/active_service/model/associations/has_one_association.rb",
    "lib/active_service/model/attributes.rb",
    "lib/active_service/model/http.rb",
    "lib/active_service/model/introspection.rb",
    "lib/active_service/model/orm.rb",
    "lib/active_service/model/parse.rb",
    "lib/active_service/model/paths.rb",
    "lib/active_service/model/relation.rb",
    "lib/active_service/model/serialization.rb",
    "lib/active_service/version.rb",
    "spec/api_spec.rb",
    "spec/collection_spec.rb",
    "spec/middleware/json_parser_spec.rb",
    "spec/model/associations_spec.rb",
    "spec/model/attributes_spec.rb",
    "spec/model/http_spec.rb",
    "spec/model/orm_spec.rb",
    "spec/model/parse_spec.rb",
    "spec/model/paths_spec.rb",
    "spec/model/relation_spec.rb",
    "spec/model_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/macros/model_macros.rb",
    "spec/support/macros/request_macros.rb"
  ]
  s.homepage = "http://github.com/zwelchcb/active_service"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "2.1.9"
  s.summary = "An object-relational mapper for web services."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.13"])
      s.add_development_dependency(%q<rspec-its>, ["~> 1.0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<fivemat>, ["~> 1.2"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.8.7"])
      s.add_development_dependency(%q<faraday_middleware>, ["~> 0.9"])
      s.add_runtime_dependency(%q<active_attr>, [">= 0"])
      s.add_runtime_dependency(%q<faraday>, ["< 1.0", ">= 0.8"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.13"])
      s.add_dependency(%q<rspec-its>, ["~> 1.0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<fivemat>, ["~> 1.2"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 1.8.7"])
      s.add_dependency(%q<faraday_middleware>, ["~> 0.9"])
      s.add_dependency(%q<active_attr>, [">= 0"])
      s.add_dependency(%q<faraday>, ["< 1.0", ">= 0.8"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.13"])
    s.add_dependency(%q<rspec-its>, ["~> 1.0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<fivemat>, ["~> 1.2"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 1.8.7"])
    s.add_dependency(%q<faraday_middleware>, ["~> 0.9"])
    s.add_dependency(%q<active_attr>, [">= 0"])
    s.add_dependency(%q<faraday>, ["< 1.0", ">= 0.8"])
  end
end

