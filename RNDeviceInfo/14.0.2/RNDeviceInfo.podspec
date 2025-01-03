require 'json'

package = JSON.parse(File.read(File.join(__dir__, "..", "..", "package.json")))

Pod::Spec.new do |s|
  s.name         = "RNDeviceInfo"
  s.version      = '14.0.2'
  s.summary      = 'Get device information using react-native'
  s.license      = package['license']

  s.authors      = 'Rebecca Hughes <rebecca@learnium.net> (https://github.com/rebeccahughes)'
  s.homepage     = 'https://github.com/react-native-device-info/react-native-device-info'
  s.platforms     = { :ios => "9.0", :visionos => "1.0", :tvos => "10.0"}

  s.source       = { :git => "https://github.com/react-native-device-info/react-native-device-info.git", :tag => "v#{s.version}" }
  s.source_files  = "ios/**/*.{h,m}"
  s.resource_bundles = {
    'RNDeviceInfoPrivacyInfo' => ['ios/PrivacyInfo.xcprivacy'],
  }

  s.dependency 'React-Core'
end
