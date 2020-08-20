//
//  Canvas.swift
//
//  Created by Osei Fortune on 7/14/19.
//  Copyright © 2019 Osei Fortune. All rights reserved.
//

import Foundation
import UIKit
import MetalKit


@objcMembers
@objc(Canvas)
public class Canvas: UIView, RenderListener {
    private static var views: NSMapTable<NSString,Canvas> = NSMapTable(keyOptions: .copyIn, valueOptions: .weakMemory)
    
    public static func getViews() -> NSMapTable<NSString,Canvas> {
        return views
    }
    var displayLink: CADisplayLink?
    var ptr: UnsafeMutableRawPointer?
    public func getViewPtr() -> UnsafeMutableRawPointer? {
        if(ptr == nil && !isGL && renderer != nil){
            ptr = Unmanaged.passRetained(renderer!.view).toOpaque()
        }
        return ptr
    }
    
    public static func createSVGMatrix() -> CanvasDOMMatrix{
        CanvasDOMMatrix()
    }
    var isContextLost: Bool = false
    var _handleInvalidationManually: Bool = false
    public var handleInvalidationManually: Bool {
        get {
            return _handleInvalidationManually
        }
        set {
            _handleInvalidationManually = newValue
            if(newValue){
                displayLink?.invalidate()
                displayLink = nil
                _fps = 0
            }else {
                displayLink = CADisplayLink(target: self, selector: #selector(handleAnimation))
                displayLink?.add(to: .main, forMode: .common)
            }
        }
    }
    public func didDraw() {
        if(dataURLCallbacks.count == 0) {return}
        DispatchQueue.main.async {
            for request in self.dataURLCallbacks {
                let result = native_to_data_url(self.canvas, request.type, request.format)
                let data = String(cString: result!)
                request.callback(data)
            }
        }
    }
    
    public func toDataURL() -> String {
        return toDataURL("image/png")
    }
    
    public func toDataURL(_ type: String) -> String {
        return toDataURL(type, 0.92)
    }
    
    public func toDataURL(_ type: String,_ format: Float) -> String {
        if(renderer?.contextType ?? .none == ContextType.webGL){
            var ss = snapshot()
            let data = Data(bytes: &ss, count: ss.count)
            return data.base64EncodedString(options: Data.Base64EncodingOptions(rawValue: 0))
            
        }
        let result = native_to_data_url(canvas, type, format)
        let data = String(cString: result!)
        native_free_char(result)
        return data
    }
    
    
    public func toDataURLAsync(_ callback: @escaping (String) -> Void) {
        toDataURLAsync("image/png", callback)
    }
    
    public func toDataURLAsync(_ type: String,_ callback: @escaping (String) -> Void) {
        toDataURLAsync(type, 0.92, callback)
    }
    
    private var dataURLCallbacks: [DataURLRequest] = []
    
    public func toDataURLAsync(_ type: String,_ format: Float,_ callback: @escaping (String) -> Void) {
        dataURLCallbacks.append(DataURLRequest(type: type, format: format, callback: callback))
    }
    
    public func snapshot() -> [UInt8]{
        let _ = renderer?.ensureIsContextIsCurrent() ?? false
        if(renderer?.contextType ?? .none == ContextType.twoD){
            let result = native_snapshot_canvas(canvas)
            let data = [UInt8](Data(bytes: result.array, count: result.length))
            native_free_byte_array(result)
            return data
        }else if(renderer?.contextType ?? .none == ContextType.webGL){
            if let gl = renderer as? GLRenderer {
                let pixels = (gl.view as! CanvasGLKView).snapshot
                let data = pixels.pngData() ?? Data()
                return [UInt8](data)
            }else if let metal = renderer as? MetalRenderer {
                let metalView = (metal.view as! MTKView)
                UIGraphicsBeginImageContextWithOptions(frame.size, true, 0.0)
                let context = UIGraphicsGetCurrentContext()!
                context.fill(frame)
                metalView.layer.render(in: context)
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                let data = image?.pngData() ?? Data()
                return [UInt8](data)
            }
        }
        return []
    }
    
    var _isGL: Bool = false
    var isDirty: Bool = false
    public var isGL: Bool {
        get {
            return _isGL
        }
    }
    
    public func getId() -> GLint {
        GLint()
    }
    
    public var width: Float {
        get {
            if(didMoveOffMain){
                return Float(cachedFrame.size.width * UIScreen.main.nativeScale)
            }
            return Float(frame.size.width * UIScreen.main.nativeScale)
        }
    }
    
    public var height: Float {
        get {
            if(didMoveOffMain){
                return Float(cachedFrame.size.height * UIScreen.main.nativeScale)
            }
            return Float(frame.size.height  * UIScreen.main.nativeScale)
        }
    }
    
    public func updateDirection(_ direction: String){
        renderer?.updateDirection(direction)
    }
    
    var didMoveOffMain: Bool = false
    var didWait: Bool = false
    var renderer: Renderer?
    public var canvas: Int64 {
        get {
            return renderer?.canvas ?? 0
        }
        set {
            renderer?.canvas = newValue
        }
    }
    public var canvasState: [Int64]  {
        get {
            return renderer?.canvasState ?? []
        }
        set {
            renderer?.canvasState = newValue
        }
    }
    var renderingContext2d: CanvasRenderingContext?
    var renderingContextWebGL: CanvasRenderingContext?
    var renderingContextWebGL2: CanvasRenderingContext?
    public func doDraw() {
        if(handleInvalidationManually){return}
        renderer?.isDirty = true
    }
    
    public func flush(){
        renderer?.render()
    }
    
    var useGL: Bool = false
    func setup(){
        if(useGL){
            _isGL = true
            renderer = GLRenderer()
        }else {
            renderer = MetalRenderer()
        }
        renderer?.setRenderListener(listener: self)
        if let view = renderer?.view {
            addSubview(view)
        }
    }
    
    public init(frame: CGRect, useGL: Bool) {
        self.useGL = useGL
        super.init(frame: frame)
        self.isOpaque = false
        self.displayLink = CADisplayLink(target: self, selector: #selector(handleAnimation))
        self.displayLink?.preferredFramesPerSecond = 60
        self.displayLink?.add(to: .main, forMode: .common)
        setup()
        if(frame != .zero || frame != .null){
            renderer?.view.frame = frame
            renderer?.updateSize()
        }
        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: nil) { _ in
            self.displayLink?.invalidate()
            self.displayLink = nil
            self._fps = 0
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { _ in
            if(self.displayLink == nil){
                self.displayLink = CADisplayLink(target: self, selector: #selector(self.handleAnimation))
                self.displayLink?.add(to: .main, forMode: .common)
            }
        }
    }
    
    var _fps: Float = 0
    public var fps: Float {
        get {
            return _fps
        }
    }
    
    @objc func handleAnimation(displayLink: CADisplayLink){
        self._fps = Float(1 / (displayLink.targetTimestamp - displayLink.timestamp))
        if(renderer?.isDirty ?? false){
            renderer?.render()
            self.renderer?.isDirty = false
        }
    }
    
    var cachedFrame: CGRect = .zero
    var cachedBounds: CGRect = .zero
    public override var frame: CGRect {
        didSet {
            cachedFrame = frame
            cachedBounds = bounds
            renderer?.view.frame = bounds
            renderer?.updateSize()
        }
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    deinit {
        if(canvas > 0){
            renderer?.resume()
            native_destroy(canvas)
            canvas = 0
        }
    }
    
    public func resume(){
        self.displayLink = CADisplayLink(target: self, selector: #selector(self.handleAnimation))
        self.displayLink?.add(to: .main, forMode: .common)
        renderer?.resume()
    }
    public func pause(){
        displayLink?.invalidate()
        displayLink = nil
        _fps = 0
        renderer?.pause()
    }
    
    public func moveToMain(){
        self.pause()
        didMoveOffMain = false
        renderer?.didMoveOffMain = false
    }
    
    public func moveOffMain(){
        self.pause()
        didMoveOffMain = true
        renderer?.didMoveOffMain = true
    }
    
    public func handleMoveOffMain(){
        self.displayLink = CADisplayLink(target: self, selector: #selector(self.handleAnimation))
        self.displayLink?.add(to: .main, forMode: .common)
        renderer?.resume()
    }
    
    public func handleMoveToMain(){
        self.displayLink = CADisplayLink(target: self, selector: #selector(self.handleAnimation))
        self.displayLink?.add(to: .main, forMode: .common)
        renderer?.resume()
    }
    
    private var emptyCanvas = CanvasRenderingContext()
    public func getContext(_ type: String) -> CanvasRenderingContext? {
        var attributes: [String: Any] = [:]
        if type.elementsEqual("2d"){
            attributes["alpha"] = true
        }else if(type.contains("webgl")){
            attributes["alpha"] = true
            attributes["depth"] = true
            attributes["failIfMajorPerformanceCaveat"] = false
            attributes["powerPreference"] = "default"
            attributes["premultipliedAlpha"] = true
            attributes["preserveDrawingBuffer"] = false
            attributes["stencil"] = false
            attributes["xrCompatible"] = false
        }
        return getContext(type, contextAttributes: attributes)
    }
    
    public func getContext(_ type: String, contextAttributes: [String: Any]) -> CanvasRenderingContext? {
        if type.elementsEqual("2d"){
            if(renderingContext2d == nil){
                renderer?.attributes = contextAttributes
                if(contextAttributes["alpha"] != nil){
                    DispatchQueue.main.async {
                        let alpha = contextAttributes["alpha"] as! Bool
                        self.renderer?.isOpaque = !alpha
                    }
                }
                renderingContext2d = CanvasRenderingContext2D(self)
                
                let alpha = contextAttributes["alpha"] as? Bool ?? true
                if(alpha){
                    glClearColor(1, 0, 0, 1)
                }else {
                    glClearColor(0, 0, 0, 1)
                }
                glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT))
            }else {
                if let gl = renderer as? GLRenderer{
                    let _ = gl.ensureIsContextIsCurrent()
                }
            }
            
            renderer?.contextType = .twoD
            // force draw to setup drawable
            
            if let renderer = renderer as? GLRenderer {
                if(renderer.canvas == 0 && renderer.width != 0 && renderer.height != 0){
                    renderer.render()
                }
            }
            return renderingContext2d!
        }else if(type.elementsEqual("webgl")){
            renderer?.contextType = .webGL
            renderer?.attributes = contextAttributes
            if(contextAttributes["alpha"] != nil){
                DispatchQueue.main.async {
                    let alpha = contextAttributes["alpha"] as? Bool ?? true
                    self.renderer?.isOpaque = !alpha
                    //  self.renderer?.render()
                }
            }
            
            if(renderingContextWebGL == nil){
                renderingContextWebGL = WebGLRenderingContext(self)
                let alpha = contextAttributes["alpha"] as? Bool ?? true
                if(alpha){
                    glClearColor(1, 0, 0, 1)
                }else {
                    glClearColor(0, 0, 0, 1)
                }
                glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT))
                
            }else {
                if let gl = renderer as? GLRenderer{
                    let _ = gl.ensureIsContextIsCurrent()
                }
            }
            
            return renderingContextWebGL!
        }else if(type.elementsEqual("webgl2")){
            if let render = renderer as? GLRenderer {
                if(render.context.api != .openGLES3){
                    return emptyCanvas
                }
            }
            renderer?.attributes = contextAttributes
            if(contextAttributes["alpha"] != nil){
                DispatchQueue.main.async {
                    let alpha = contextAttributes["alpha"] as? Bool ?? true
                    self.renderer?.isOpaque = !alpha
                }
            }
            if(renderingContextWebGL2 == nil){
                renderingContextWebGL2 = WebGL2RenderingContext(self)
                let alpha = contextAttributes["alpha"] as? Bool ?? true
                if(alpha){
                    glClearColor(0, 0, 0, 0)
                }else {
                    glClearColor(0, 0, 0, 1)
                }
                glClear(GLbitfield(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT))
            }else {
                if let gl = renderer as? GLRenderer{
                    let _ = gl.ensureIsContextIsCurrent()
                }
            }
            renderer?.contextType = .webGL
            return renderingContextWebGL2!
        }
        return emptyCanvas
    }
}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}
