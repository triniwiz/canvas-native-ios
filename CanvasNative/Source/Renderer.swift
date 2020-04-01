//
//  Renderer.swift
//  CanvasNative
//
//  Created by Osei Fortune on 3/24/20.
//

import Foundation
public protocol Renderer {
    var canvas: Int64   {get set}
    var canvasState: [Int64] {get set}
    var view: UIView { get }
    var width: Float {get}
    var height: Float {get}
    func setup()
    func render()
    func updateSize()
    func setRenderListener(listener: RenderListener?)
}


public protocol RenderListener {
    func didDraw()
}
