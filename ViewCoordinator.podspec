Pod::Spec.new do |s|
  s.name             = 'ViewCoordinator'
  s.version          = '0.1.0'
  s.summary          = 'Elegant way to manipulate your UIViews presentation and dismissal from any given Controller.'

  s.description      = <<-DESC
Instead of hiding views that you'd need to present at a certain time, you would just need to drop all your views into a container, then use the ViewCoordinator mechanism to bring them back into screen.
                       DESC

  s.homepage         = 'https://github.com/lamourBt/ViewCoordinator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lamourBt' => 'lamour2016@hotmail.com' }
  s.source           = { :git => 'https://github.com/lamourBt/ViewCoordinator.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
  s.frameworks = 'UIKit'

  s.source_files = 'ViewCoordinator/Classes/**/*'

end
