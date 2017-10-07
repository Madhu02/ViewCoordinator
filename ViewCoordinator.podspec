
Pod::Spec.new do |s|
  s.name             = 'ViewCoordinator'
  s.version          = '0.2.0'
  s.summary          = 'Elegant way to manipulate and display UIViews onto a Controller'

s.description      = <<-DESC
Instead of hiding views that you'd need to present at a certain time, you would just need to drop all your views into a container, then use the ViewCoordinator mechanism to bring them back into screen.
DESC

  s.homepage         = 'https://github.com/LamourBt/ViewCoordinator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'LamourBt' => 'lamour2016@hotmail.com' }
  s.source           = { :git => 'https://github.com/LamourBt/ViewCoordinator.git', :tag => s.version.to_s }

  
  s.platform     = :ios

  #s.ios.deployment_target = '8.0'

  s.source_files = 'ViewCoordinator/Classes/**/*'
  
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }

end
