require 'json'
package = JSON.parse(File.read(File.join(__dir__, "..", "..", "package.json")))

Pod::Spec.new do |s|
  s.name           = "RNVectorIcons"
  s.version        = "10.2.0"
  s.summary        = "Customizable Icons for React Native with support for NavBar/TabBar, image source and full styling."
  s.description    = "Customizable Icons for React Native with support for NavBar/TabBar, image source and full styling."
  s.homepage       = "https://github.com/oblador/react-native-vector-icons"
  s.license        = package["license"]
  s.author         = { "Joel Arvidsson" => "joel@oblador.se" }
  s.platforms      = { :ios => "12.0", :tvos => "9.0" ,:visionos => "1.0"}
  s.source         = { :git => "git://github.com/oblador/react-native-vector-icons.git", :tag => "v#{s.version}" }

  s.source_files   = 'RNVectorIconsManager/**/*.{h,m,mm,swift}'
  s.resources      = "Fonts/*.ttf"
  s.preserve_paths = "**/*.js"
  # React Native Core dependency
  if defined? install_modules_dependencies
    install_modules_dependencies(s)
  else
    s.dependency 'React-Core'
  end
end
