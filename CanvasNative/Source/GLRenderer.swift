//
//  GLRenderer.swift
//  CanvasNative
//
//  Created by Osei Fortune on 3/24/20.
//

import Foundation
import GLKit
import UIKit

@objcMembers
@objc(CanvasGLKView)
public class CanvasGLKView: GLKView {
    var isDirty: Bool = false
    public init() {
        super.init(frame: .zero)
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public override func setNeedsDisplay() {
        super.setNeedsDisplay()
        isDirty = true
    }
    
    public override func setNeedsDisplay(_ rect: CGRect) {
        super.setNeedsDisplay(rect)
        isDirty = true
    }
}


public class GLRenderer: NSObject, Renderer, GLKViewDelegate {
    public var isDirty: Bool {
        set{
            glkView.isDirty = newValue
        }
        get{
            return glkView.isDirty
        }
    }
    
    var listener: RenderListener?
    var displayRenderbuffer: GLuint
    var displayFramebuffer: GLuint
    var depthRenderbuffer: GLuint
    static var sharedGroup: EAGLSharegroup =  EAGLSharegroup()
    public var canvasState: [Int64] = []
    
    public var canvas: Int64 = 0
    
    public var view: UIView {
        get {
            return glkView
        }
    }
    
    public var width: Float {
        get {
            return Float(view.frame.size.width * UIScreen.main.nativeScale)
        }
    }
    
    public var height: Float {
        get {
            return Float(view.frame.height * UIScreen.main.nativeScale)
        }
    }
    
    var glkView: CanvasGLKView
    var scale: Float
    var didExit: Bool = false
    var context: EAGLContext
    var currentOrientation: UIDeviceOrientation
    public override init() {
        glkView = CanvasGLKView() //GLKView()
        displayFramebuffer = GLuint()
        displayRenderbuffer = GLuint()
        depthRenderbuffer = GLuint()
        var context = EAGLContext(api: .openGLES3, sharegroup: GLRenderer.sharedGroup)
        if context == nil {
            context = EAGLContext(api: .openGLES2, sharegroup: GLRenderer.sharedGroup)
        }
        self.context = context!
        // glkView.isUserInteractionEnabled = false
        scale = Float(UIScreen.main.nativeScale)
        currentOrientation = UIDevice.current.orientation
        super.init()
        glkView.context = context!
        
        glkView.contentScaleFactor = CGFloat(scale)
        (glkView.layer as! CAEAGLLayer).isOpaque = false
        (glkView.layer as! CAEAGLLayer).drawableProperties = [
            kEAGLDrawablePropertyRetainedBacking : false,
            kEAGLDrawablePropertyColorFormat: kEAGLColorFormatRGBA8,
        ]
        //(glkView.layer as! CAEAGLLayer).presentsWithTransaction = false
        glkView.drawableDepthFormat = .format24
        glkView.drawableStencilFormat = .format8
        glkView.drawableColorFormat = .RGBA8888
        glkView.enableSetNeedsDisplay = false
        glkView.delegate = self
        glkView.contentMode = .bottomLeft
        glkView.drawableMultisample = .multisample4X
        _ = ensureIsContextIsCurrent()
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
        let ensured = EAGLContext.setCurrent(context)
        if(canvas == 0 && displayFramebuffer > 0 && contextType == .twoD){
            glViewport(0, 0, GLsizei(width), GLsizei(height))
            let scale:CGFloat = CGFloat(self.scale)
            let width = Int32(glkView.drawableWidth)
            let height = Int32(glkView.drawableHeight)
            glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
            canvas = native_init_legacy(width, height, Int32(displayFramebuffer), Float(scale))
        }
        return ensured
    }
    
    
    var fboid = GLint()
    public func setup() {
        let width = Int32(glkView.drawableWidth)
        let height = Int32(glkView.drawableHeight)
        if(!done && (width > 0 && height > 0)){
            done = true
            glClearColor(1.0, 1.0, 1.0, 1.0)
            glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
            var binding = GLint(0)
            glGetIntegerv(GLenum(GL_FRAMEBUFFER_BINDING), &binding)
            displayFramebuffer = GLuint(binding)
        }
        if(contextType == .twoD && canvas == 0 && displayFramebuffer > 0){
            let _ = ensureIsContextIsCurrent()
            if(canvas == 0){
                done = true
                let scale:CGFloat = CGFloat(self.scale)
                glViewport(0, 0, GLsizei(width), GLsizei(height))
                glClearColor(1.0, 1.0, 1.0, 1.0)
                glClear(GLbitfield(GL_COLOR_BUFFER_BIT))
                canvas = native_init_legacy(width, height, Int32(displayFramebuffer), Float(scale))
            }
        }
    }
    
    
    public var contextType: ContextType  = .none
    
    public func render() {
        if(didExit){return}
        let _ = ensureIsContextIsCurrent()
        glkView.display()
        DispatchQueue.main.async {
            self.listener?.didDraw()
        }
    }
    
    public func flush(){
        if(didExit){return}
        let _ = ensureIsContextIsCurrent()
        glkView.isDirty = true
        DispatchQueue.main.async {
            self.listener?.didDraw()
        }
    }
    
    public func ensureIsReady(){
        glkView.isDirty = true
    }
    
    
    public func updateSize() {
        let _ = ensureIsContextIsCurrent()
        if(contextType == .twoD && done && canvas > 0){
            let width = Int32(glkView.drawableWidth)
            let height = Int32(glkView.drawableHeight)
            
            if(UIDevice.current.orientation != currentOrientation){
                glViewport(0, 0, width, height)
                /* TODO fix rotation */
                /*
                var binding = GLint(0)
                glGetIntegerv(GLenum(GL_FRAMEBUFFER_BINDING), &binding)
                if(displayFramebuffer != binding){
                    displayFramebuffer = GLuint(binding)
                }
                
                canvas = native_surface_resized_legacy(width, height, Int32(displayFramebuffer), scale, canvas)
                currentOrientation = UIDevice.current.orientation*/
                /* TODO fix rotation */
            }else {
                glViewport(0, 0, width, height)
            }
            
            lastSize = ["width": Int(width), "height": Int(height)]
            
        }else if(contextType == .twoD && !done && canvas == 0){
            glkView.display()
        }
    }
    
    public func pause(){
        //EAGLContext.setCurrent(nil)
    }
    
    public func resume(){
        let _ = ensureIsContextIsCurrent()
    }
    
    var done: Bool = false
    var resize: Bool = false
    var lastSize: [String:Int] = ["width":0,"height":0]
    
    func internalFlush(){
        canvas = native_flush(canvas)
    }
    
    public func glkView(_ view: GLKView, drawIn rect: CGRect){
        setup()
        internalFlush()
    }
}
