Pod::Spec.new do |s|

    s.name         = "CanvasNative"

    s.version      = "0.0.1"

    s.summary      = "A Canvas library"

    s.homepage     = "https://github.com/triniwiz/canvas-native-ios"


    s.license      = { :type => "MIT", :file => "LICENSE" }


    s.author             = { "Osei Fortune" => "fortune.osei@yahoo.com" }

    s.platform     = :ios, "11.0"

    s.source       = { :git => "https://github.com/triniwiz/canvas-native-ios.git", :tag => "#{s.version}" }

    s.source_files  = 'CanvasNative/**/*.{swift,m,h,modulemap}'
    s.preserve_paths = 'CanvasNative/include/*.h', 'CanvasNative/include/**/*.h', 'CanvasNative/libs/*.a'
    s.pod_target_xcconfig = {
'USER_HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/CanvasNative/include"',
'LIBRARY_SEARCH_PATHS' => '"${PODS_ROOT}/CanvasNative/libs"',
'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/CanvasNative/include"',
'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'
 }
    s.swift_versions = ['4.0','4.2', '5.0']
    s.vendored_libraries = 'CanvasNative/libs/*.a'
    s.public_header_files = 'CanvasNative/include/*.h'
    s.libraries = 'c++'
  end
