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
        return toDataURL(type: "image/png")
    }
    
    public func toDataURL(type: String) -> String {
        return toDataURL(type: type, format: 0.92)
    }
    
    public func toDataURL(type: String, format: Float) -> String {
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
    
    
    public func toDataURLAsync(callback: @escaping (String) -> Void) {
        toDataURLAsync(type: "image/png", callback: callback)
    }
    
    public func toDataURLAsync(type: String, callback: @escaping (String) -> Void) {
        toDataURLAsync(type: type, format: 0.92, callback: callback)
    }
    
    private var dataURLCallbacks: [DataURLRequest] = []
    
    public func toDataURLAsync(type: String, format: Float, callback: @escaping (String) -> Void) {
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
            return Float(frame.size.width * UIScreen.main.nativeScale)
        }
    }
    
    public var height: Float {
        get {
            return Float(frame.size.height  * UIScreen.main.nativeScale)
        }
    }
    
    
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
    
    public override var frame: CGRect {
        didSet {
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
    
    private var emptyCanvas = CanvasRenderingContext()
    public func getContext(type: String) -> CanvasRenderingContext {
        var attributes: [String:Any] = [:]
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
        return getContext(type: type, contextAttributes: attributes)
    }
    
    public func getContext(type: String, contextAttributes: [String: Any]) -> CanvasRenderingContext {
        if type.elementsEqual("2d"){
            if(renderingContext2d == nil){
                renderingContext2d = CanvasRenderingContext2D(canvas: self)
            }else {
                if let gl = renderer as? GLRenderer{
                    let _ = gl.ensureIsContextIsCurrent()
                }
            }
            
            renderer?.contextType = .twoD
            // force draw to setup drawable
            
            if(contextAttributes["alpha"] != nil){
                let alpha = contextAttributes["alpha"] as! Bool
                renderer?.isOpaque = !alpha
            }
            if let renderer = renderer as? GLRenderer {
                if(renderer.canvas == 0 && renderer.width != 0 && renderer.height != 0){
                    renderer.render()
                }
            }
            return renderingContext2d!
        }else if(type.elementsEqual("webgl")){
            if(renderingContextWebGL == nil){
                renderingContextWebGL = WebGLRenderingContext(canvas: self)
            }else {
                if let gl = renderer as? GLRenderer{
                    let _ = gl.ensureIsContextIsCurrent()
                }
            }
            renderer?.contextType = .webGL
            if(contextAttributes["alpha"] != nil){
                let alpha = contextAttributes["alpha"] as! Bool
                renderer?.isOpaque = !alpha
            }
            return renderingContextWebGL!
        }else if(type.elementsEqual("webgl2")){
            if let render = renderer as? GLRenderer {
                if(render.context.api != .openGLES3){
                    return emptyCanvas
                }
            }
            if(renderingContextWebGL2 == nil){
                renderingContextWebGL2 = WebGL2RenderingContext(canvas: self)
                if(contextAttributes["alpha"] != nil){
                    let alpha = contextAttributes["alpha"] as! Bool
                    renderer?.isOpaque = !alpha
                }
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
