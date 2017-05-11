#
# Be sure to run `pod lib lint WRLD.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WRLD'
  #s.version          = '##WRLD_IOS_SDK_VERSION##'
  s.version          = '0.0.1.test.07'
  s.summary          = 'Dynamic 3D maps for iOS'

  s.description      = 'Display 3D outdoor and indoor maps and markers using OpenGL'

  s.homepage         = 'https://github.com/eegeo/ios-api'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'BSD 2-Clause', :file => 'LICENSE.md' }
  s.author           = { 'eeGeo' => 'support@eegeo.com' }
  s.social_media_url  = 'https://twitter.com/eegeo'

  s.source = {
    :http => "https://s3.amazonaws.com/eegeo-static/wrld-ios-sdk/builds/test/wrld-ios-sdk-v#{s.version.to_s}.zip",
    :flatten => true
  }


  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.requires_arc = true


  s.vendored_frameworks = 'Wrld.framework', 'WrldWidgets.framework'
  s.module_name = 'Wrld'
end

