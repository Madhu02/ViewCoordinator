#
# Be sure to run `pod lib lint ViewCoordinator.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ViewCoordinator'
  s.version          = '0.1.0'
  s.summary          = 'Elegant way to manipulate and display UIViews onto a Controller'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
Instead of hiding views that you'd need to present at a certain time, you would just need to drop all your views into a container, then use the ViewCoordinator mechanism to bring them back into screen.
DESC

  s.homepage         = 'https://github.com/LamourBt/ViewCoordinator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LamourBt' => 'lamour2016@hotmail.com' }
  s.source           = { :git => 'https://github.com/LamourBt/ViewCoordinator.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ViewCoordinator/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ViewCoordinator' => ['ViewCoordinator/Assets/*.png']
  # }

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }

  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
