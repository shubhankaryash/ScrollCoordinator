#
# Be sure to run `pod lib lint ScrollCoordinator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ScrollCoordinator'
  s.version          = '0.1.0'
  s.summary          = 'ScrollCoordinator allows you to attach gestures to scrollviews and perform behaviours on these gestures.'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/shubhankaryash/ScrollCoordinator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'shubhankaryash' => 'shubhankaryash' }
  s.source           = { :git => 'https://github.com/shubhankaryash/ScrollCoordinator.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ScrollCoordinator/Sources/**/*'
  
  # s.resource_bundles = {
  #   'ScrollCoordinator' => ['ScrollCoordinator/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
