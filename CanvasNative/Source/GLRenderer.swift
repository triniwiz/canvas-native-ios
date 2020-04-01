//
//  GLRenderer.swift
//  CanvasNative
//
//  Created by Osei Fortune on 3/24/20.
//

import Foundation
import GLKit
import UIKit

public class GLRenderer: NSObject, Renderer, GLKViewDelegate {
    var listener: RenderListener?
    public var canvasState: [Int64] = []
    
    public var canvas: Int64 = 0
    
    public var view: UIView {
        get {
            return glkView
        }
    }
    
    public var width: Float {
        get {
            return Float(glkView.frame.width * UIScreen.main.nativeScale)
        }
    }
    
    public var height: Float {
        get {
            return Float(glkView.frame.height * UIScreen.main.nativeScale)
        }
    }
    
    var glkView: GLKView
    var scale: Float
    var didExit: Bool = false
    public override init() {
        glkView = GLKView()
        scale = Float(UIScreen.main.nativeScale)
        super.init()
        glkView.contentScaleFactor = CGFloat(scale)
        glkView.context = EAGLContext(api: .openGLES2)!
        (glkView.layer as! CAEAGLLayer).isOpaque = false
        (glkView.layer as! CAEAGLLayer).drawableProperties = [
            kEAGLDrawablePropertyRetainedBacking: NSNumber(value:false),
            kEAGLDrawablePropertyColorFormat: kEAGLColorFormatRGBA8
        ]
        glkView.drawableDepthFormat = .format24
        glkView.drawableStencilFormat = .format8
        glkView.drawableColorFormat = .RGBA8888
        glkView.enableSetNeedsDisplay = true
        glkView.delegate = self
        glkView.contentMode = .bottomLeft
        let _ = ensureIsContextIsCurrent()
        exitObserver = NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: nil) { _ in
            self.didExit = true
        }
        
        enterObserver = NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { _ in
            self.didExit = false
        }
    }
    
    var exitObserver: Any?
    var enterObserver: Any?
    
    public func setRenderListener(listener: RenderListener?) {
        self.listener = listener
    }
    
    deinit {
        if(exitObserver != nil){
            NotificationCenter.default.removeObserver(exitObserver!)
        }
        if(enterObserver != nil){
            NotificationCenter.default.removeObserver(enterObserver!)
        }
    }
    
    public func ensureIsContextIsCurrent() -> Bool{
        return EAGLContext.setCurrent(glkView.context)
    }
    
    
    var fboid = GLint()
    public func setup() {
        if(!done) {
            
        }
    }
    
    public func render() {
        if(didExit){return}
        let _ = ensureIsContextIsCurrent()
        glkView.setNeedsDisplay()
    }
    
    public func updateSize() {
        if(done){
            resize = true
        }
    }
    
    var done: Bool = false
    var resize: Bool = false
    var lastSize: [String:Int] = ["width":0,"height":0]
    public func glkView(_ view: GLKView, drawIn rect: CGRect) {
        
        let _ = ensureIsContextIsCurrent()
        
        glClear(GLbitfield(GL_DEPTH_BUFFER_BIT | GL_COLOR_BUFFER_BIT | GL_STENCIL_BUFFER_BIT))
        glViewport(0, 0, GLsizei(view.drawableWidth), GLsizei(view.drawableHeight))
        
        if(!done){
            glClearColor(1.0, 1.0, 1.0, 1.0)
            glGetIntegerv(GLenum(GL_FRAMEBUFFER_BINDING), &fboid)
            let scale:CGFloat = CGFloat(self.scale)
            let width = Int32(glkView.drawableWidth)
            let height = Int32(glkView.drawableHeight)
            canvas = native_init_legacy(width, height, fboid, Float(scale))
            done = true
        }
        canvas = native_flush(canvas)
        listener?.didDraw()
    }
}
