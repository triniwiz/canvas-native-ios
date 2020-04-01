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
           let result = native_to_data_url(canvas, type, format)
           let data = String(cString: result!)
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
    
    var _isGL: Bool = false
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
    private var renderingContext2d: CanvasRenderingContext?
    public func doDraw() {
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
    public override init(frame frameRect: CGRect) {
        super.init(frame: frameRect)
        setup()
        renderer?.view.frame = frameRect
    }
    
    public init(frame: CGRect, useGL: Bool) {
        self.useGL = useGL
        super.init(frame: frame)
        setup()
        renderer?.view.frame = frame
        self.isOpaque = false
    }
    
    public override func layoutSubviews() {
        renderer?.view.frame = frame
        renderer?.updateSize()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func doAnimation(displayLink: CADisplayLink){
    }

    deinit {

    }
    
    public func getContext(type: String) -> CanvasRenderingContext? {
        if type.elementsEqual("2d"){
            if(renderingContext2d == nil){
                renderingContext2d = CanvasRenderingContext2D(canvas: self)
            }
            return renderingContext2d
        }
        return nil
    }

}

extension String {
    subscript(_ range: CountableRange<Int>) -> String {
        let idx1 = index(startIndex, offsetBy: max(0, range.lowerBound))
        let idx2 = index(startIndex, offsetBy: min(self.count, range.upperBound))
        return String(self[idx1..<idx2])
    }
}
