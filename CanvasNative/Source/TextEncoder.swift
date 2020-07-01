//
//  TextEncoder.swift
//  CanvasNative
//
//  Created by Osei Fortune on 5/14/20.
//

import Foundation
@objcMembers
@objc(NativeTextEncoder)
public class NativeTextEncoder: NSObject {
    private var nativeEncoder: Int64 = 0
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
        nativeEncoder = native_create_text_encoder(type)
    }
    
    public var encoding: String {
        let raw = native_text_encoder_get_encoding(nativeEncoder)
        if(raw == nil){
            // Return default utf8 ?
            return String()
        }
        let encoding = String(cString: raw!)
        native_free_char(raw)
        return encoding
    }
    
    public func encode(text: String) -> NSData {
        let txt = (text as NSString).utf8String
        let result = native_text_encoder_encode(nativeEncoder, txt)
        let bytes = NSData(bytes: result.array, length: result.length)
        native_free_byte_array(result)
        return bytes
    }
    
    deinit {
        native_text_encoder_free(nativeEncoder)
    }
}
