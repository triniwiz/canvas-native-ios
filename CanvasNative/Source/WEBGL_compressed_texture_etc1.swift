//
//  WEBGL_compressed_texture_etc1.swift
//  CanvasNative
//
//  Created by Osei Fortune on 4/27/20.
//

import Foundation
import OpenGLES
@objcMembers
@objc(Canvas_WEBGL_compressed_texture_etc1)
public class Canvas_WEBGL_compressed_texture_etc1: NSObject {
    public override init() {
        
    }
    
    public var COMPRESSED_RGB_ETC1_WEBGL: Int32 {
        return GL_COMPRESSED_RGB_PVRTC_4BPPV1_IMG
    }
}
