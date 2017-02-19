Pod::Spec.new do |s|
  s.name             = 'Bacteria'
  s.version          = '0.5'
  s.summary          = 'Framework for iOS Modal Controller Transitions'
  s.description      = <<-DESC
	Framework is for basic modal viewcontroller transitions with human syntax. Special developed for ObjC users
                       DESC

  s.homepage         = 'https://github.com/igorkislyuk/bacteria'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Igor Kislyuk' => 'igorkislyuk@icloud.com' }
  s.source           = { :git => 'https://github.com/igorkislyuk/bacteria.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/igorkislyuk'

  s.ios.deployment_target = '7.0'

  s.source_files = 'Bacteria/**/*'
  s.frameworks = 'UIKit'
end