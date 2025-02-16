require "json"


is_gh_example_app = ENV["GH_EXAMPLE_APP_NAME"] != nil

compilation_metadata_dir = "CompilationDatabase"
compilation_metadata_generation_flag = is_gh_example_app ? '-gen-cdb-fragment-path ' + compilation_metadata_dir : ''

Pod::Spec.new do |s|
  # NPM package specification
  package = JSON.parse(File.read(File.join(__dir__, "..", "..", "package.json")))

  s.name         = "RNGestureHandler"
  s.version      = "2.21.2"
  s.summary      = "Declarative API exposing native platform touch and gesture system to React Native"
  s.homepage     = "https://github.com/software-mansion/react-native-gesture-handler"
  s.license      = "MIT"
  s.author       = { "Krzysztof Magiera" => "krzys.magiera@gmail.com" }
  s.source       = { :git => "https://github.com/software-mansion/react-native-gesture-handler", :tag => "#{s.version}" }
  s.source_files = "apple/**/*.{h,m,mm}"
  s.requires_arc = true
  s.platforms       = { ios: '11.0', tvos: '11.0', osx: '10.15', visionos: '1.0' }
  s.xcconfig = {
    "OTHER_CFLAGS" => "$(inherited) " + compilation_metadata_generation_flag
  }

  if defined?(install_modules_dependencies()) != nil
    install_modules_dependencies(s);
  else
    s.dependency "React-Core"
  end
end