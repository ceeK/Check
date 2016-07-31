Pod::Spec.new do |s|
  s.name         = "Check"
  s.version      = "0.0.1"
  s.summary      = "A Swift mocking library"
  s.description  = "A Swift mock library for creating concise, DRY mocks. Check has been designed to work when using protocols to inject dependencies."
  s.homepage     = "http://github.com/ceek/Check"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Chris Howell" => "chris.kevin.howell@gmail.com" }
  s.social_media_url   = "https://twitter.com/howellck"
  s.platform     = :ios
  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'
  s.source       = { :git => "https://github.com/ceek/Check.git", :tag => "#{s.version}" }
  s.source_files  = "Check/*.{swift}"
  s.requires_arc = true
end
