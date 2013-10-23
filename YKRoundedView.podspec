Pod::Spec.new do |s|
  s.name         = "YKRoundedView"
  s.version      = "0.0.1"
  s.summary      = "A rounded view like UITableViewCell grouped"
  s.homepage     = "https://github.com/yoshiki/YKRoundedView"
  s.license      = 'MIT'
  s.author       = { "Yoshiki Kurihara" => "clouder@gmail.com" }
  s.platform     = :ios
  s.ios.deployment_target = '4.3'
  s.source       = { :git => "https://github.com/yoshiki/YKRoundedView.git", :tag => "1.0.0" }
  s.source_files  = 'YKRoundedView/*.{h,m}'
  s.framework  = 'QuartzCore'
  s.requires_arc = true
end
