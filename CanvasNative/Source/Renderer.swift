//
//  Renderer.swift
//  CanvasNative
//
//  Created by Osei Fortune on 3/24/20.
//

import Foundation
import UIKit
public protocol Renderer {
    var canvas: Int64   {get set}
    var canvasState: [Int64] {get set}
    var contextType: ContextType {get set}
    var view: UIView { get }
    var width: Float {get}
    var height: Float {get}
    func setup()
    func render()
    func flush()
    func updateSize()
    func setRenderListener(listener: RenderListener?)
    func pause()
    func resume()
}


public protocol RenderListener {
    func didDraw()
}


public enum ContextType: Int, RawRepresentable {
       case none
       case webGL
       case twoD
}
