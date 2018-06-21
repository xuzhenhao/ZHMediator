Pod::Spec.new do |s|
  s.name             = 'ZHMediator'
  s.version          = '0.1.0'
  s.summary          = 'Mediator For Modules to communicate without coupling 模块间解耦的中间件，包含了本地调用及远程URL调用两种模式'

  s.homepage         = 'https://github.com/xuzhenhao/ZHMediator'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xuzhenhao' => '632476744@qq.com' }
  s.source           = { :git => 'https://github.com/xuzhenhao/ZHMediator.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.2'

  s.source_files = 'ZHMediator/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZHMediator' => ['ZHMediator/Assets/*.png']
  # }

  s.public_header_files = 'ZHMediator/Classes/ZHMediator.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'JLRoutes', '~> 2.1'
end
