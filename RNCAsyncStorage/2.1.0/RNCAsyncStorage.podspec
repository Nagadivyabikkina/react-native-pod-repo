require 'json'
# require_relative "../../new_architecture.rb"

package = JSON.parse(File.read(File.join(__dir__, "..", "..", "package.json")))

fabric_enabled = ENV['RCT_NEW_ARCH_ENABLED'] == '1'

Pod::Spec.new do |s|
  s.name         = "RNCAsyncStorage"
  s.version      = "2.1.0"
  s.summary      = "Asynchronous, persistent, key-value storage system for React Native."
  s.license      = package['license']

  s.authors      = "Krzysztof Borowy <contact@kborowy.com>"
  s.homepage     = "https://github.com/react-native-async-storage/async-storage#readme"

  s.source       = { :git => "https://github.com/react-native-async-storage/async-storage.git", :tag => "v#{s.version}" }
  s.source_files  = "ios/**/*.{h,m,mm}"
  s.resource_bundles = { "RNCAsyncStorage_resources" => "ios/PrivacyInfo.xcprivacy" }

  if fabric_enabled
    folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'

    s.pod_target_xcconfig = {
      'HEADER_SEARCH_PATHS' => '"$(PODS_ROOT)/boost" "$(PODS_ROOT)/boost-for-react-native" "$(PODS_ROOT)/RCT-Folly"',
      'CLANG_CXX_LANGUAGE_STANDARD' => 'c++17',
    }
    s.platforms       = { ios: '13.4', tvos: '11.0', :osx => "10.15", :visionos => "1.0" }
    s.compiler_flags  = folly_compiler_flags + ' -DRCT_NEW_ARCH_ENABLED=1'

    if respond_to?(:install_modules_dependencies, true)
      install_modules_dependencies(s)
    else
      s.dependency "React-Core"
      s.dependency "React-Codegen"
      s.dependency "RCT-Folly"
      s.dependency "RCTRequired"
      s.dependency "RCTTypeSafety"
      s.dependency "ReactCommon/turbomodule/core"
    end
  else
    s.platforms = { :ios => "9.0", :tvos => "9.2", :osx => "10.14", :visionos => "1.0" }

    s.dependency "React-Core"
  end
end
