//
//  ImageAsset.swift
//  CanvasNative
//
//  Created by Osei Fortune on 5/4/20.
//

import Foundation

@objcMembers
@objc(ImageAsset)
public class ImageAsset: NSObject {
    private var nativeAsset: Int64 = 0
    public static var _queue: DispatchQueue?
    private static var queue: DispatchQueue {
        if(_queue == nil){
            _queue = DispatchQueue(label: "ImageAssetQueue", qos: .background, attributes:.concurrent, autoreleaseFrequency: .never, target: nil)
        }
        return _queue!
    }
    public override init() {
       self.nativeAsset =  native_create_image_asset()
    }
    private var _error: String?
    public func loadImageFromPath(path: String) -> Bool{
        let ptr = (path as NSString).utf8String
        return native_image_asset_load_from_path(nativeAsset, ptr) != 0
    }
    
    public func loadImageFromPathAsync(path: String, callback: @escaping (String?)-> ()){
        ImageAsset.queue.async {
            let success = self.loadImageFromPath(path: path)
            if(success){
                DispatchQueue.main.async {
                    callback(nil)
                }
            }else {
                DispatchQueue.main.async {
                     callback(self.error!)
                }
            }
        }
    }
    
    public func loadImageFromBytes(array: [UInt8]) -> Bool{
        var ptr = array
        return native_image_asset_load_from_raw(nativeAsset, &ptr, array.count) != 0
    }
    
    public func loadImageFromBytesAsync(array: [UInt8], callback: @escaping (String?)-> ()){
        ImageAsset.queue.async {
            let success = self.loadImageFromBytes(array: array)
            if(success){
                DispatchQueue.main.async {
                    callback(nil)
                }
            }else {
                DispatchQueue.main.async {
                     callback(self.error!)
                }
            }
        }
    }
    
    public func loadImageFromImage(image: UIImage) -> Bool {
        var cgImage: CGImage?
        if let pixels = image.cgImage {
                   cgImage = pixels
               } else if let image = image.ciImage {
            let ctx = CIContext()
                cgImage = ctx.createCGImage(image, from: image.extent)
               }
               if let pixels = cgImage {
                
               let width = Int(pixels.width)
                                  let height = Int(pixels.height)
                                  let buffer = calloc(width * height, 4)
                let size = width * height * 4
                let imageCtx = CGContext(data: buffer, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue)
                                  imageCtx!.draw(pixels, in: CGRect(x: 0, y: 0, width: width, height: height))
                                 
                let result = native_image_asset_load_from_raw(nativeAsset, buffer?.assumingMemoryBound(to: UInt8.self), size)
                buffer?.deallocate()
               return result != 0
               }
        return false
    }
    
    public func loadImageFromImageAsync(image: UIImage, callback: @escaping (String?)-> ()){
        ImageAsset.queue.async {
            let success = self.loadImageFromImage(image: image)
            if(success){
                DispatchQueue.main.async {
                    callback(nil)
                }
            }else {
                DispatchQueue.main.async {
                     callback(self.error!)
                }
            }
        }
    }
    
    public func getRawBytes() -> UnsafeMutablePointer<UInt8>? {
        if(nativeAsset == 0){return nil}
        let raw = native_image_asset_get_bytes(nativeAsset)
        var bytes = [UInt8](Data(bytes: raw.array, count: raw.length))
        native_image_asset_free_bytes(raw)
        
        return bytes.withUnsafeMutableBytes { (ptr) -> UnsafeMutablePointer<UInt8>? in
            ptr.baseAddress?.assumingMemoryBound(to: UInt8.self)
        }
    }
    
    public var width: Int32 {
        if(nativeAsset == 0){
            return 0
        }
        return Int32(native_image_asset_get_width(nativeAsset))
    }
    
    public var height: Int32 {
       if(nativeAsset == 0){
           return 0
       }
        return Int32(native_image_asset_get_height(nativeAsset))
    }
    
    public func flipX(){
        if(nativeAsset == 0){
            return
        }
        native_image_asset_flip_x(nativeAsset)
    }
    
    public func flipY(){
        if(nativeAsset == 0){
            return
        }
        
        native_image_asset_flip_y(nativeAsset)
    }
    
    public func scale(x: UInt32, y: UInt32){
        if(nativeAsset == 0){
            return
        }
        native_image_asset_scale(nativeAsset, x, y)
    }
    
    public func save(path: String,format: ImageAssetFormat)-> Bool{
        let pathPtr = (path as NSString).utf8String
        return native_native_image_asset_save_path(nativeAsset, pathPtr, UInt32(format.rawValue)) != 0
    }
    
    public func saveAsync(path: String,format: ImageAssetFormat, callback: @escaping (Bool)-> ()){
        ImageAsset.queue.async {
            let success = self.save(path: path, format: format)
            if(success){
                DispatchQueue.main.async {
                    callback(true)
                }
            }else {
                DispatchQueue.main.async {
                     callback(false)
                }
            }
        }
    }
    
    public var error: String? {
        if(nativeAsset == 0){
            return nil
        }
        return String(cString: native_image_asset_get_error(nativeAsset))
    }
    
    deinit {
        if(nativeAsset != 0){
            native_image_asset_release(nativeAsset)
        }
    }
}

