//
//  GLUtils.swift
//  CanvasNative
//
//  Created by Osei Fortune on 26/07/2020.
//

import Foundation
import UIKit

class GLUtils {
    static var device: MTLDevice?
    static var glContext: EAGLContext?
    static func getBytesFromImage(pixels: UIImage) -> UnsafeMutableRawPointer?{
        var cgImage: CGImage?
        device = MTLCreateSystemDefaultDevice()
        if(device == nil){
            glContext = EAGLContext(api: .openGLES3)
            if(glContext == nil){
                glContext = EAGLContext(api: .openGLES2)
            }
        }
        if let image = pixels.cgImage {
            cgImage = image
        }else if let image = pixels.ciImage {
            var context: CIContext?
            if let mtlDevice = device {
                context = CIContext(mtlDevice: mtlDevice)
            }
            if let glCtx = glContext {
                context = CIContext(eaglContext: glCtx)
            }
            if let ctx = context {
                cgImage = ctx.createCGImage(image, from: image.extent)
            }
        }
        
        if let image = cgImage {
            let width = Int(pixels.size.width)
            let height = Int(pixels.size.height)
            let buffer = calloc(width * height, 4)
            let imageCtx = CGContext(data: buffer, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: image.colorSpace!, bitmapInfo: image.alphaInfo.rawValue)
            imageCtx!.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))
            return buffer
        }
        return nil
    }
}
