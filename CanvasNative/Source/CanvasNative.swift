//
//  CanvasNative.swift
//
//  Created by Osei Fortune on 7/14/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import UIKit
import OpenGLES
import GLKit
@objc(CanvasNative)
public class CanvasNative: GLKView, GLKViewDelegate {
    var canvas: Int64 = 0
    var canvasState: [Int64] = []
    private var renderingContext2d: CanvasRenderingContext?
    var done: Bool = false
    public override init(frame: CGRect) {
        super.init(frame: frame)
        //contentScaleFactor = 1.0
        contentScaleFactor = UIScreen.main.nativeScale
        context = EAGLContext(api: .openGLES2)!
        (layer as! CAEAGLLayer).isOpaque = false
        drawableMultisample = .multisample4X
        drawableDepthFormat = .format24
        drawableStencilFormat = .format8
        drawableColorFormat = .RGBA8888
        delegate = self
        let _ = ensureIsContextIsCurrent()
    }


    static func currentContext() -> EAGLContext? {
        return EAGLContext.current()
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("Canvas init(coder:) Not Supported!")
    }

    func getFrameBufferId() -> GLint {
        var defaultFBO = GLint()
        glGetIntegerv(GLenum(GL_FRAMEBUFFER_BINDING_OES), &defaultFBO);
        return defaultFBO
    }

    func getStencil() -> GLint {
        var stencil = GLint()
        glGetIntegerv(GLenum(GL_STENCIL_BITS), &stencil)
        return stencil
    }


    public func ensureIsContextIsCurrent() -> Bool{
        return EAGLContext.setCurrent(context)
    }
    var colorBufferID = GLuint()
    var stencilBufferID = GLuint()
    var depthRenderbuffer = GLuint()
    public func glkView(_ view: GLKView, drawIn rect: CGRect) {
        if !done {
            let defaultFBO = getFrameBufferId()
            //glClearColor(0.0, 0.0, 0.0, 1.0)
            //glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT))
            let scale = UIScreen.main.scale
            let width = Int32(frame.width * scale)
            let height = Int32(frame.height * scale)
            let S = 4
            let W = width
            let H = height
            glGenRenderbuffers(1, &colorBufferID)
            glBindRenderbuffer(GLenum(GL_RENDERBUFFER), colorBufferID)
            glRenderbufferStorageMultisample(GLenum(GL_RENDERBUFFER), GLsizei(S), GLenum(GL_RGBA8), W, H);
            /*
            glGenRenderbuffers(1, &stencilBufferID)
            glBindRenderbuffer(GLenum(GL_RENDERBUFFER), stencilBufferID)
            glRenderbufferStorageMultisample(GLenum(GL_RENDERBUFFER), GLsizei(S), GLenum(GL_STENCIL_INDEX8), W, H);
            */
            glGenRenderbuffersOES(1, &depthRenderbuffer);
            glBindRenderbufferOES(GLenum(GL_RENDERBUFFER_OES), depthRenderbuffer);
            glRenderbufferStorageOES(GLenum(GL_RENDERBUFFER_OES), GLenum(GL_DEPTH_COMPONENT24_OES), width, height);
            glFramebufferRenderbufferOES(GLenum(GL_FRAMEBUFFER_OES), GLenum(GL_DEPTH_ATTACHMENT_OES), GLenum(GL_RENDERBUFFER_OES), depthRenderbuffer);


             let degrees = 180.0
             transform = CGAffineTransform(rotationAngle: CGFloat(Float(degrees * .pi/180)))
             transform = CGAffineTransform(scaleX: 1, y: -1)

            self.canvas = native_init(width,height, defaultFBO, Float(scale))
            done = true
        }

        glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT))

    }

    public func getContext(type: String) -> CanvasRenderingContext? {
        if type.elementsEqual("2d"){
            return CanvasRenderingContext2D(canvas: self)
        }
        return nil
    }

}



extension UIColor {
    convenience init(fromHex hex: String) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if cString.count == 3 {
            let first = cString[0..<1]
            let second = cString[1..<2]
            let third = cString[2..<3]
            cString =  "" + first +  first  + second  + second  + third  + third
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }


    var colorCode: Int {
        get {
            var fRed : CGFloat = 0
            var fGreen : CGFloat = 0
            var fBlue : CGFloat = 0
            var fAlpha: CGFloat = 0
            if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
                let iRed = Int(fRed * 255.0)
                let iGreen = Int(fGreen * 255.0)
                let iBlue = Int(fBlue * 255.0)
                let iAlpha = Int(fAlpha * 255.0)

                //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
                return (iAlpha << 24) + (iRed << 16) + (iGreen << 8) + iBlue
            } else {
                // Could not extract RGBA components: return black
                let iRed = Int(0.0 * 255.0)
                let iGreen = Int(0.0 * 255.0)
                let iBlue = Int(0.0 * 255.0)
                let iAlpha = Int(1.0 * 255.0)


                return (iAlpha << 24) + (iRed << 16) + (iGreen << 8) + iBlue
            }
        }
    }
}


extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}
