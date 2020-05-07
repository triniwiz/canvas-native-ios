//
//  OES_vertex_array_object.swift
//  CanvasNative
//
//  Created by Osei Fortune on 4/27/20.
//

import Foundation
import OpenGLES
@objcMembers
@objc(Canvas_OES_vertex_array_object)
public class Canvas_OES_vertex_array_object: NSObject {
    public override init() {}
    
    public var VERTEX_ARRAY_BINDING_OES: Int32 {
        return GL_VERTEX_ARRAY_BINDING_OES
    }
}
