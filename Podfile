# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'My_restaurant_app' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!


  pod 'Kingfisher'
  pod 'Socket.IO-Client-Swift'
  pod 'AlertToast'
  pod 'Wormholy'

  target 'UnitTests' do
    inherit! :search_paths
    # Pods for testing
  end


end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
    end
  end
end

