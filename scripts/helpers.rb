# Copyright (c) Meta Platforms, Inc. and affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

require_relative './utils.rb'

# Helper object to wrap the invocation of sysctl
# This makes it easier to mock the behaviour in tests
class SysctlChecker
    def call_sysctl_arm64
        return `/usr/sbin/sysctl -n hw.optional.arm64 2>&1`.to_i
    end
end

# Helper class that is used to easily send commands to Xcodebuild
# And that can be subclassed for testing purposes.
class Xcodebuild
    def self.version
        `xcodebuild -version`
    end
end

# Helper object to wrap system properties like RUBY_PLATFORM
# This makes it easier to mock the behaviour in tests
class Environment
    def ruby_platform
        return RUBY_PLATFORM
    end
end

class Finder
    def self.find_codegen_file(path)
        js_files = '-name "Native*.js" -or -name "*NativeComponent.js"'
        ts_files = '-name "Native*.ts" -or -name "*NativeComponent.ts"'
        return `find #{path} -type f \\( #{js_files} -or #{ts_files} \\)`.split("\n").sort()
    end
end


module Helpers
    class Constants
        @@boost_config = {
            :git => "https://github.com/react-native-community/boost-for-react-native",
        }

        @@socket_rocket_config = {
            :version => '0.7.1'
        }

        @@folly_config = {
            :version => '2024.01.01.00',
            :git => 'https://github.com/facebook/folly.git',
            :compiler_flags => '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1 -DFOLLY_CFG_NO_COROUTINES=1 -DFOLLY_HAVE_CLOCK_GETTIME=1 -Wno-comma -Wno-shorten-64-to-32'
        }

        @@fmt_config = {
            :git => "https://github.com/fmtlib/fmt.git",
        }

        @@glog_config = {
            :git => "https://github.com/google/glog.git",
        }

        @@double_conversion_config = {
            :git => "https://github.com/google/double-conversion.git",
        }

        def self.min_ios_version_supported
            return '15.1'
        end

        def self.min_xcode_version_supported
            return '15.1'
        end

        def self.folly_config
            return @@folly_config
        end

        def self.get_folly_config()
          return @@folly_config
        end

        def self.set_folly_config(new_folly_config)
            @@folly_config.update(new_folly_config)
        end

        def self.boost_config
            return @@boost_config
        end

        def self.set_boost_config(new_boost_config)
           @@boost_config.update(new_boost_config)
        end

        def self.socket_rocket_config
            return @@socket_rocket_config
        end

        def self.set_socket_rocket_config(new_socket_rocket_config)
           @@socket_rocket_config.update(new_socket_rocket_config)
        end

        def self.fmt_config
            return @@fmt_config
        end

        def self.set_fmt_config(new_fmt_config)
            @@fmt_config.update(new_fmt_config)
        end

        def self.glog_config
            return @@glog_config
        end

        def self.set_glog_config(new_glog_config)
            @@glog_config.update(new_glog_config)
        end

        def self.double_conversion_config
            return @@double_conversion_config
        end

        def self.set_double_conversion_config(new_double_conversion_config)
            @@double_conversion_config.update(new_double_conversion_config)
        end

        def self.cxx_language_standard
            return "c++20"
        end
        def self.add_dependency(spec, pod_name, subspec: nil, additional_framework_paths: [], framework_name: nil, version: nil, base_dir: "PODS_CONFIGURATION_BUILD_DIR")
             fixed_framework_name = framework_name != nil ? framework_name : pod_name.gsub("-", "_") # frameworks can't have "-" in their name
             ReactNativePodsUtils.add_dependency(spec, pod_name, base_dir, fixed_framework_name, :additional_paths => additional_framework_paths, :version => version)
        end

    end
end
