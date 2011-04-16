Gem::Specification.new do |s|
  s.name = "google-adwords-api"
  s.version = "0.1.1"
  s.date = "2011-04-16"
  s.author = "modified by taf2"
  s.email = "todd.fisher@gmail.com"
  s.homepage = "https://github.com/taf2/google-api-ads-ruby"
  s.platform = Gem::Platform::RUBY
  s.summary = "Ads API Client Libraries for Ruby"
  s.description = "Ported from http://code.google.com/p/google-api-ads-ruby/, but nicely packaged I hope"
  s.files = Dir.glob("{ads_common/,adwords_api}/**/*")
  s.require_path = ["ads_common/lib", "adwords_api/lib"]
  s.add_dependency("soap4r", ">= 1.5.8")
end
