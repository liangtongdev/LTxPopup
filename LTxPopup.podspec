Pod::Spec.new do |s|
  s.name         = "LTxPopup"
  s.version      = "0.0.5"
  s.summary      = "包含各类弹出框组件. "
  s.license      = "MIT"
  s.author             = { "liangtong" => "liangtongdev@163.com" }

  s.homepage     = "https://github.com/liangtongdev/LTxPopup"
  s.platform     = :ios, "9.0"
  s.ios.deployment_target = "9.0"
  s.source       = { :git => "https://github.com/liangtongdev/LTxPopup.git", :tag => "#{s.version}" }

  s.frameworks = "Foundation", "UIKit"

  s.default_subspecs = 'Core'

  # Common
  s.subspec 'Common' do |common|
    common.source_files  =  "LTxPopup/LTxPopupCommon/*.{h,m}"
    common.public_header_files = "LTxPopup/LTxPopupCommon/*.h"
  end

  # Menu
  s.subspec 'Menu' do |menu|
    menu.source_files  =  "LTxPopup/LTxPopupMenu/*.{h,m}"
    menu.public_header_files = "LTxPopup/LTxPopupMenu/*.h"
  end

  # View
  s.subspec 'View' do |view|
    view.source_files  =  "LTxPopup/LTxPopupView/*.{h,m}"
    view.public_header_files = "LTxPopup/LTxPopupView/*.h"
    view.dependency 'LTxPopup/Common'
  end

  # Alert
  s.subspec 'Alert' do |alert|
    alert.source_files  =  "LTxPopup/LTxPopupAlert/*.{h,m}"
    alert.public_header_files = "LTxPopup/LTxPopupAlert/*.h"
  end

  # Toast
  s.subspec 'Toast' do |toast|
    toast.source_files  =  "LTxPopup/LTxPopupToast/*.{h,m}"
    toast.public_header_files = "LTxPopup/LTxPopupToast/*.h"
    toast.dependency 'LTxPopup/Common'
  end


  # Core
  s.subspec 'Core' do |core|
    core.dependency 'LTxPopup/Menu'
    core.dependency 'LTxPopup/View'
    core.dependency 'LTxPopup/Alert'
    core.dependency 'LTxPopup/Toast'
    core.source_files  =  "LTxPopup/LTxPopup.h"
    core.public_header_files = "LTxPopup/LTxPopup.h"
  end


end
