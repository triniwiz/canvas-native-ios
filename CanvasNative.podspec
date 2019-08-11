Pod::Spec.new do |s|

    s.name         = "CanvasNative"

    s.version      = "0.0.1"

    s.summary      = "A Canvas library"

    s.homepage     = "https://github.com/triniwiz/canvas-native-ios"


    s.license      = { :type => "MIT", :file => "LICENSE" }


    s.author             = { "Osei Fortune" => "fortune.osei@yahoo.com" }

    s.platform     = :ios, "9.0"

    s.source       = { :git => "https://github.com/triniwiz/canvas-native-ios.git", :tag => "#{s.version}" }

    s.source_files  = 'CanvasNative/**/*.{swift,m,h,modulemap,a}'
    s.preserve_paths = 'CanvasNative/Canvas/*.modulemap' , 'CanvasNative/Canvas/libs/*.a'
    s.pod_target_xcconfig = {
'USER_HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/CanvasNative/include"',
'LIBRARY_SEARCH_PATHS' => '"${PODS_ROOT}/CanvasNative/libs"',
'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/CanvasNative/include" "${PODS_ROOT}/CanvasNative/Canvas"',
'SWIFT_INCLUDE_PATHS' => '"${PODS_ROOT}/CanvasNative/Canvas"',
'MODULEMAP_PRIVATE_FILE' => '"${PODS_ROOT}/CanvasNative/Canvas/Canvas.private.modulemap"',
'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES'
 }
  s.private_header_files = 'include/*.h'
  s.vendored_library = 'libs/*.a'
  s.swift_versions = ['4.0', '4.2','5.0']
  end
