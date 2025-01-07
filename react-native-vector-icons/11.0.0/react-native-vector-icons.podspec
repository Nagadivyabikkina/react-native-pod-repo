require "json"

package = JSON.parse(File.read(File.join(__dir__, "..", "..", "package.json")))
folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -Wno-comma -Wno-shorten-64-to-32'

Pod::Spec.new do |s|
  s.name         = "react-native-vector-icons"
  s.version      = "11.0.0"
  s.summary      = "Customizable Icons for React Native with support for image source and full styling."
  s.homepage     = "https://github.com/oblador/react-native-vector-icons"
  s.license      = package["license"]
  s.authors      = "Joel Arvidsson"

  s.platforms    = { :ios => min_ios_version_supported, :tvos => "9.0", :visionos => "1.0" }
  s.source       = { :git => "git://github.com/oblador/react-native-vector-icons.git", :tag => "v#{s.version}" }

  s.source_files = "ios/**/*.{h,m,mm,cpp}"

  # Use install_modules_dependencies helper to install the dependencies if React Native version >=0.71.0.
  # See https://github.com/facebook/react-native/blob/febf6b7f33fdb4904669f99d795eba4c0f95d7bf/scripts/cocoapods/new_architecture.rb#L79.
  if respond_to?(:install_modules_dependencies, true)
    install_modules_dependencies(s)
  else
    s.dependency "React-Core"

    # Don't install the dependencies when we run `pod install` in the old architecture.
    if ENV['RCT_NEW_ARCH_ENABLED'] == '1' then
      s.compiler_flags = folly_compiler_flags + " -DRCT_NEW_ARCH_ENABLED=1"
      s.pod_target_xcconfig = {
          "HEADER_SEARCH_PATHS" => "\"$(PODS_ROOT)/boost\"",
          "OTHER_CPLUSPLUSFLAGS" => "-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1",
          "CLANG_CXX_LANGUAGE_STANDARD" => "c++17"
      }
      s.dependency "React-Codegen"
      s.dependency "RCT-Folly"
      s.dependency "RCTRequired"
      s.dependency "RCTTypeSafety"
      s.dependency "ReactCommon/turbomodule/core"
    end
  end

  s.script_phase = {
    :name => 'Copy Fonts',
    :script => <<~SCRIPT
      set -e

      WITH_ENVIRONMENT="$REACT_NATIVE_PATH/scripts/xcode/with-environment.sh"

      /bin/sh -c "\"$WITH_ENVIRONMENT\" \"${PODS_TARGET_SRCROOT}/scripts/copy-fonts.sh\""
    SCRIPT
  }
end