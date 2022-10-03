#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint kryptografi.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'kryptografi'
  s.version          = '0.0.1'
  s.summary          = 'secure library for cryptography'
  s.description      = <<-DESC
secure library for cryptography
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'SwiftyRSA', "~> 1.5.0"
  s.platform = :ios, '9.0'
  s.ios.deployment_target = '8.3'
  s.swift_version = '4.0'
end
