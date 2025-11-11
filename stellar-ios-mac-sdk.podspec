Pod::Spec.new do |s|
  s.name         = "stellar-ios-mac-sdk"
  s.version      = "3.2.7"
  s.summary      = "Fully featured iOS and macOS SDK that provides APIs to build transactions and connect to Horizon server for the Stellar ecosystem."
  s.module_name  = 'stellarsdk'
  s.swift_version = '5.0'

  s.description  = <<-DESC
  The Soneso iOS and macOS Stellar SDK facilitates integration with the Stellar Horizon API server and submission of Stellar transactions, either in your iOS or macOS app.
  DESC

  s.homepage     = "https://github.com/Soneso/stellar-ios-mac-sdk"
  s.license      = { :type => "Apache 2.0", :file => "LICENSE" }
  s.author       = { "Soneso" => "stellarsdk@soneso.com" }

  s.ios.deployment_target = "13.0"
  s.osx.deployment_target = "10.15"

  s.source = { :git => "https://github.com/jkatayama/stellar-ios-mac-sdk.git", :branch => "master" }

  # Include all source files (Swift, Obj-C, and C)
  s.source_files = "stellarsdk/stellarsdk/**/*.{h,m,swift,c}"
  
  # Public headers
  s.public_header_files = [
    "stellarsdk/stellarsdk/stellarsdk.h",
    "stellarsdk/stellarsdk/libs/ed25519-C/include/ed25519.h"
  ]
  
  # Exclude unnecessary files
  s.exclude_files = [
    "stellarsdk/stellarsdk/Info.plist",
    "stellarsdk/stellarsdk/libs/ed25519-C/license.txt"
  ]
  
  # Preserve the modulemap so Swift can find the ed25519C module
  s.preserve_paths = "stellarsdk/stellarsdk/libs/ed25519-C/module.modulemap"

  # Critical configuration for ed25519C module
  s.pod_target_xcconfig = {
    'SWIFT_VERSION' => '5.0',
    'HEADER_SEARCH_PATHS' => '$(PODS_TARGET_SRCROOT)/stellarsdk/stellarsdk/libs/ed25519-C/include',
    # CRITICAL: Use both PODS_TARGET_SRCROOT and PODS_ROOT to cover all cases
    'SWIFT_INCLUDE_PATHS' => '$(inherited) $(PODS_TARGET_SRCROOT)/stellarsdk/stellarsdk/libs/ed25519-C $(PODS_ROOT)/stellar-ios-mac-sdk/stellarsdk/stellarsdk/libs/ed25519-C',
    'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) ED25519_CUSTOMIZATION=1',
    'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'
  }
  
  # This propagates to app targets
  s.user_target_xcconfig = {
    'SWIFT_INCLUDE_PATHS' => '$(inherited) $(PODS_ROOT)/stellar-ios-mac-sdk/stellarsdk/stellarsdk/libs/ed25519-C'
  }
end