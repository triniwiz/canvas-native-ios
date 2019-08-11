Pod::Spec.new do |s|

    s.name         = "CanvasNative"

    s.version      = "0.0.1"

    s.summary      = "A Canvas library"

    s.homepage     = "https://github.com/triniwiz/canvas-native"


    s.license      = { :type => "MIT", :file => "LICENSE" }


    s.author             = { "Osei Fortune" => "fortune.osei@yahoo.com" }

    s.platform     = :ios, "9.0"

    s.source       = { :git => "https://github.com/triniwiz/canvas-native.git", :tag => "#{s.version}" }

    s.source_files  = 'Canvas**/*.{swift,m,h,modulemap,a}'

    s.pod_target_xcconfig = {
'USER_HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/CanvasNative/include"',
'LIBRARY_SEARCH_PATHS' => '"${PODS_ROOT}/CanvasNative/libs"',
'HEADER_SEARCH_PATHS' => '"${PODS_ROOT}/CanvasNative/include"',
'SWIFT_INCLUDE_PATHS' => '"${PODS_ROOT}/CanvasNative/Canvas"',
'MODULEMAP_PRIVATE_FILE' => '"${PODS_ROOT}/CanvasNative/Canvas/Canvas.private.modulemap"'
 }
  s.private_header_files = 'include/*.h'
  s.deployment_target   = '9.0'
  s.vendored_library = 'libs/libcanvasnative.a'
  s.swift_versions = ['4.0', '4.2','5.0']
  end
