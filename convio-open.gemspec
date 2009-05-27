require 'rubygems'

SPEC=Gem::Specification.new { |s|
  s.name='convio-open'
  s.version='0.1'
  s.author='Brandon Wiley'
  s.email='brandon@moontower.us'
  s.homepage='http://stepthreeprofit.com/'
  s.platform=Gem::Platform::RUBY
  s.summary="A library to access the Convio APIs"
  candidates=Dir.glob("{bin,docs,lib,text}/**/*")
  s.files=candidates.delete_if { |item|
    item.include?(".git") || item.include?("rdoc")
  }
  s.require_path="lib"
  s.test_file="test/test.rb"
  s.has_rdoc=false
  s.extra_rdoc_files=["README"]
  s.add_dependency("json", ">= 1.1.3")
}
