//
//  MetalRenderer.swift
//  CanvasNative
//
//  Created by Osei Fortune on 3/24/20.
//

import Foundation
import UIKit
import MetalKit
public class MetalRenderer:NSObject, Renderer, MTKViewDelegate {
    var listener: RenderListener?
    public func setRenderListener(listener: RenderListener?) {
        self.listener = listener
    }
    
    public func updateSize() {
        mtlView.drawableSize = CGSize(width: mtlView.frame.size.width * CGFloat(scale), height: mtlView.frame.size.height * CGFloat(scale))
    }
    
    public var canvas: Int64 = 0
    public var canvasState: [Int64] = []
    var scale: Float
    var done: Bool = false
    public func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        setup()
    }
    
    public func setup() {
        if(!done){
            canvas = native_init(0, 0, devicePtr, queuePtr, viewPtr, Float(scale))
            done = true
        }
    }
    
    
    public var width: Float {
        get {
            return Float(mtlView.frame.size.width * CGFloat(scale))
        }
    }
    
    public var height: Float {
        get {
            return Float(mtlView.frame.size.height * CGFloat(scale))
        }
    }
    
    public func draw(in view: MTKView) {
        view.clearColor = MTLClearColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if(!pending) {return}
        canvas = native_flush(canvas)
        guard let commandBuffer = queue?.makeCommandBuffer() else {return}
        guard let drawable = mtlView.currentDrawable else {return}
        
        // https://stackoverflow.com/questions/60774782/addpresentedhandler-not-being-triggered-in-metal-on-ios
        #if targetEnvironment(simulator)
        commandBuffer.addCompletedHandler { _ in
            self.listener?.didDraw()
        }
        #else
        drawable.addPresentedHandler { _ in
            self.listener?.didDraw()
        }
        #endif
        
        commandBuffer.present(drawable)
        commandBuffer.commit()
        pending = false
    }
    
    var mtlDevice: MTLDevice?
    var queue: MTLCommandQueue?
    var devicePtr: UnsafeMutableRawPointer?
    var queuePtr: UnsafeMutableRawPointer?
    var viewPtr: UnsafeMutableRawPointer?
    var texturePtr: UnsafeMutableRawPointer?
    var layerPtr: UnsafeMutableRawPointer?
    var drawQueue = DispatchQueue(label: "CanvasMetalQueue", qos: .userInteractive, attributes: [], autoreleaseFrequency: .workItem)
    private var mtlView: MTKView
    
    override init() {
        mtlView = MTKView()
        mtlDevice = MTLCreateSystemDefaultDevice()
        queue = mtlDevice?.makeCommandQueue()
        scale = Float(UIScreen.main.scale)
        super.init()
        mtlView.device = mtlDevice
        mtlView.isOpaque = true
        mtlView.layer.isOpaque = false
        mtlView.colorPixelFormat = .bgra8Unorm
        mtlView.framebufferOnly = true
        mtlView.isPaused = true
        mtlView.enableSetNeedsDisplay = true
        mtlView.presentsWithTransaction = false
        mtlView.sampleCount = 1
        mtlView.delegate = self
        //mtlView.autoResizeDrawable = false
        mtlView.clearColor  = MTLClearColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        devicePtr = Unmanaged.passRetained(mtlDevice!).toOpaque()
        queuePtr = Unmanaged.passRetained(queue!).toOpaque()
        layerPtr = Unmanaged.passRetained(self.mtlView.layer).toOpaque()
        viewPtr = Unmanaged.passRetained(self.mtlView).toOpaque()
    }
    public var view: UIView {
        get {
            return self.mtlView
        }
    }
    private var pending: Bool = false
    public func render() {
        pending = true
        self.mtlView.setNeedsDisplay()
    }
}
