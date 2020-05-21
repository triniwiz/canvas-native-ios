Pod::Spec.new do |s|

    s.name         = "CanvasNative"

    s.version      = "0.5.1"

    s.summary      = "A Canvas library"

    s.homepage     = "https://github.com/triniwiz/canvas-native-ios"


    s.license      = { :type => "MIT", :file => "LICENSE" }


    s.author       = { "Osei Fortune" => "fortune.osei@yahoo.com" }

    s.platform     = :ios, "11.0"

    s.source       = { :git => "https://github.com/triniwiz/canvas-native-ios.git", :tag => "#{s.version}" }

    #s.preserve_path = 'CanvasNative/include/stbi/stbi.modulemap'
    #s.module_map = 'CanvasNative/include/stbi/stbi.modulemap'
    s.source_files  = 'CanvasNative/**/*.{swift,m,h,modulemap,c}'
    s.preserve_paths = 'CanvasNative/include/*.h', 'CanvasNative/include/**/*.h', 'CanvasNative/include/**/**/*.h', 'CanvasNative/libs/*.a'
    s.pod_target_xcconfig = {
'USER_HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/CanvasNative/include" "${PODS_ROOT}/CanvasNative/CanvasNative/include"',
'LIBRARY_SEARCH_PATHS' => '"${PODS_ROOT}/CanvasNative/libs" "${PODS_ROOT}/CanvasNative/CanvasNative/libs"',
'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/CanvasNative/include" "${PODS_ROOT}/CanvasNative/CanvasNative/include"',
'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES',
'ENABLE_BITCODE' => 'NO'
 }
    s.swift_versions = ['4.0','4.2', '5.0']
    s.vendored_libraries = 'CanvasNative/libs/*.a'
    s.public_header_files = 'CanvasNative/include/*.h'
    s.libraries = 'c++'
  end
