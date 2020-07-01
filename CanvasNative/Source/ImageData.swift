//
//  ImageData.swift
//  CanvasNative
//
//  Created by Osei Fortune on 8/12/19.
//

import Foundation

@objcMembers
@objc(ImageData)
public class ImageData: NSObject {
    private var _width: Int
    private var _height: Int
    private var _data: [UInt8]
    public init(width: Int, height: Int) {
        _width = width
        _height = height
        let data = native_create_image_data(width, height)
        _data = [UInt8](Data(bytes: data.array, count: data.length))
        native_drop_image_data(data)
    }
    public var width: Int {
        get {
            return _width
        }
    }
    public var height: Int {
        get {
            return _height
        }
    }
    public var data: [UInt8] {
        get {
            return _data
        }
    }
    
    init(width: Int, height: Int, data: [UInt8]) {
        _width = width
        _height = height
        _data = data
    }
}
