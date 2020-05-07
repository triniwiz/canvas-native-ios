//
//  OES_element_index_uint.swift
//  CanvasNative
//
//  Created by Osei Fortune on 4/27/20.
//

import Foundation
import OpenGLES
@objcMembers
@objc(Canvas_OES_element_index_uint)
public class Canvas_OES_element_index_uint: NSObject {
    public override init() {
        
    }
    
    public var UNSIGNED_INT: Int32 {
        return GL_UNSIGNED_INT_OES
    }
}
