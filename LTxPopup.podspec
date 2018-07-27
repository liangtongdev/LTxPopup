Pod::Spec.new do |s|
  s.name         = "LTxPopup"
  s.version      = "0.0.2"
  s.summary      = "包含各类弹出框组件. "
  s.license      = "MIT"
  s.author             = { "liangtong" => "liangtongdev@163.com" }

  s.homepage     = "https://github.com/liangtongdev/LTxPopup"
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/liangtongdev/LTxPopup.git", :tag => "#{s.version}" }

  s.frameworks = "Foundation", "UIKit"

  s.default_subspecs = 'Core'

  # Menu
  s.subspec 'Menu' do |menu|
    menu.source_files  =  "LTxPopup/LTxPopupMenu/*.{h,m}"
    menu.public_header_files = "LTxPopup/LTxPopupMenu/*.h"
  end

  # View
  s.subspec 'View' do |view|
    view.source_files  =  "LTxPopup/LTxPopupView/*.{h,m}"
    view.public_header_files = "LTxPopup/LTxPopupView/*.h"
  end

  # Core
  s.subspec 'Core' do |core|
    core.dependency 'LTxPopup/Menu'
    core.dependency 'LTxPopup/View'
    core.source_files  =  "LTxPopup/LTxPopup.h"
    core.public_header_files = "LTxPopup/LTxPopup.h"
  end


end
