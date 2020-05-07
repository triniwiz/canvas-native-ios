//
//  WebGLActiveInfo.swift
//  CanvasNative
//
//  Created by Osei Fortune on 4/16/20.
//

import Foundation
@objcMembers
@objc(WebGLActiveInfo)
public class WebGLActiveInfo: NSObject {
    var _name: String
    var _size: Int32
    var _type: Int32
    
    public var name: String {
        get {
            return _name
        }
    }
    public var size: Int32{
        get {
            return _size
        }
    }
    
    public var type: Int32 {
        return _type
    }
    
    public init(name: String, size: Int32, type: Int32) {
        _name = name
        _size = size
        _type = type
    }
}
