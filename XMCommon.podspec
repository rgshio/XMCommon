Pod::Spec.new do |s|
  s.name         = "XMCommon"
  s.version      = "1.0.0"
  s.summary      = "XMCommon is a common class."
  s.description  = <<-DESC
                   A longer description of XMCommon in Markdown format.
                   DESC
  s.homepage     = "https://github.com/rgshio/XMCommon"
  s.license      = "MIT"
  s.author             = { "rgshio" => "754086445@qq.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/rgshio/XMCommon.git", :tag => "1.0.0" }
  s.source_files  = "XMCommon/Classes/*"
  s.requires_arc = true

end
