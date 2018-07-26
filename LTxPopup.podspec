Pod::Spec.new do |s|
  s.name         = "LTxPopup"
  s.version      = "0.0.1"
  s.summary      = "包含各类弹出框组件. "
  s.license      = "MIT"
  s.author             = { "liangtong" => "liangtongdev@163.com" }

  s.homepage     = "https://github.com/liangtongdev/LTxPopup"
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/liangtongdev/LTxPopup.git", :tag => "#{s.version}" }

  s.frameworks = "Foundation", "UIKit"

  s.default_subspecs = 'PopMenu'

  # PopMenu
  s.subspec 'PopMenu' do |menu|
    menu.source_files  =  "LTxPopup/LTxPopupMenu/*.{h,m}"
    menu.public_header_files = "LTxPopup/LTxPopupMenu/*.h"
  end



end
