//
//  TextDecoder.swift
//  CanvasNative
//
//  Created by Osei Fortune on 5/14/20.
//

import Foundation
@objcMembers
@objc(NativeTextDecoder)
public class NativeTextDecoder: NSObject {
    
    private var nativeDecoder: Int64 = 0
    public override init() {
        super.init()
        create(encoding: "utf-8")
    }
    
    public init(encoding: String){
        super.init()
        create(encoding: encoding)
    }
    
    private func create(encoding: String){
        let type = (encoding as NSString).utf8String
        nativeDecoder = native_create_text_decoder(type)
    }
    
    public var encoding: String {
        return String(cString: native_text_decoder_get_encoding(nativeDecoder))
    }
    
    public func decode(buffer: Data) -> String{

        var data = [UInt8](buffer)
        let raw = native_text_decoder_decode(nativeDecoder, &data, buffer.count)
        if(raw == nil){
            return String()
        }
        return String(cString: raw!)
    }
    
    public func decode(bytes: [UInt8]) -> String{
        var data = bytes
        let raw = native_text_decoder_decode(nativeDecoder, &data, bytes.count)
        if(raw == nil){
            return String()
        }
        return String(cString: raw!)
    }
    
    deinit {
        native_text_decoder_free(nativeDecoder)
    }
    
}
