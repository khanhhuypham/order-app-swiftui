# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
platform :ios, '13.0'
target 'My_restaurant_app' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for My_restaurant_app
  pod 'Kingfisher'
  pod 'Socket.IO-Client-Swift'
  pod "SwiftSignatureView"
  pod 'OTPFieldView'
  pod 'AlertToast'
  
#    pod 'lottie-ios'
#  pod 'RealmSwift'
  # Pods for Example
  pod 'Wormholy'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
end
