Pod::Spec.new do |s|
  s.name         = 'XMCommon'
  s.version      = '0.1.0'
  s.license      = 'MIT'
  s.summary      = 'extension class.'
  s.description  = %{XMCommon is a extension Class.}
  s.homepage     = 'https://github.com/rgshio/XMCommon'
  s.author       = { 'rgshio' => 'rgshio@qq.com' }

  s.source       = { :git => 'https://github.com/rgshio/XMCommon.git', :tag => "v#{s.version}" }

  s.source_files = 'Classes/XMExtension/*.{h,m}'
  s.ios.frameworks = 'Foundation', 'UIKit'
  s.ios.deployment_target = '7.0' # minimum SDK with autolayout

  s.requires_arc = true

end
