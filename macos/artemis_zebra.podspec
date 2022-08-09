#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint artemis_zebra.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'artemis_zebra'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter project.'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }

  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.11'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'

  s.static_framework = true
  s.preserve_paths = 'libZSDK_API.a', 'ExternalAccessory.framework', 'QuartzCore.framework'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework ExternalAccessory -framework QuartzCore -lZSDK_API' }
  s.vendored_libraries = 'libZSDK_API'
  s.vendored_frameworks = 'ExternalAccessory.framework', 'QuartzCore.framework'
end
