Pod::Spec.new do |s|
  s.name         = 'XMCommon'
  s.version      = "0.0.1"
  s.license      = 'MIT'
  s.summary      = 'XMCommon is a common class.'
  s.description  = <<-DESC
                   It is always used on iOS, which implement by Objective-C.
                   DESC
  s.homepage     = 'https://github.com/rgshio/XMCommon'
  s.author       = { 'rgshio' => 'xzy0819@qq.com' }

  s.source       = { :git => 'https://github.com/rgshio/XMCommon.git', :tag => "v#{s.version}" }

  s.source_files = 'XMCommon/Classes/XMExtension/*.{h,m}'
  s.ios.frameworks = 'Foundation', 'UIKit'
  s.ios.deployment_target = '6.0' # minimum SDK with autolayout

  s.requires_arc = true

end
