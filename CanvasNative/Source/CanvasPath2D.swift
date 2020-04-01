//
//  CanvasPath2D.swift
//  CanvasNative
//
//  Created by Osei Fortune on 3/26/20.
//

import Foundation
@objcMembers
@objc(CanvasPath2D)
public class CanvasPath2D: NSObject {
    
    var path: Int64 = 0
    
    deinit {
        native_free_path_2d(self.path)
        path = 0
    }
    public override init() {
        path = native_create_path_2d()
    }
    public init(path: CanvasPath2D) {
        self.path = native_create_path_from_path(path.path)
    }
    
    public init(data: String){
        path = native_create_path_2d_from_path_data(data)
    }
    public func addPath(path: CanvasPath2D){
        self.addPath(path: path, transform: nil)
    }
    public func addPath(path: CanvasPath2D, transform: CanvasDOMMatrix?){
        self.path = native_path_2d_add_path(self.path, path.path, transform?.matrix ?? 0)
    }
    
    public func closePath(){
        path = native_path_2d_close_path(path)
    }
    
    public func moveTo(x: Float, y: Float){
        path =  native_path_2d_move_to(path, x, y)
    }
    
    public func lineTo(x: Float, y: Float){
        path =  native_path_2d_line_to(path, x, y)
    }
    
    public func bezierCurveTo(cp1x: Float, cp1y: Float, cp2x: Float, cp2y: Float, x: Float, y: Float) {
        path = native_path_2d_bezier_curve_to(path, cp1x, cp1y, cp2x, cp2y, x, y)
    }
    
    public func quadraticCurveTo(cpx: Float, cpy: Float, x: Float, y: Float){
        path = native_path_2d_quadratic_curve_to(path, cpx, cpy, x, y)
    }
    
    
    public func arc(x: Float, y: Float, radius: Float, startAngle: Float, endAngle: Float) {
        arc(x: x, y: y, radius: radius, startAngle: startAngle, endAngle: endAngle, anticlockwise: false);
    }
    
    public func arc(x: Float, y: Float, radius: Float, startAngle: Float, endAngle: Float, anticlockwise: Bool) {
        path = native_path_2d_arc(path, x, y, radius, startAngle, endAngle, anticlockwise)
    }
    
    public func arcTo(x1: Float, y1: Float, x2: Float, y2: Float, radius: Float) {
        path = native_path_2d_arc_to(path, x1, y1, x2, y2, radius)
    }
    
    
    public func ellipse(x: Float, y: Float, radiusX: Float, radiusY: Float, rotation: Float, startAngle: Float, endAngle: Float) {
        ellipse(x: x, y: y, radiusX: radiusX, radiusY: radiusY, rotation: rotation, startAngle: startAngle, endAngle: endAngle, anticlockwise: false)
    }
    
    public func ellipse(x: Float, y: Float, radiusX: Float, radiusY: Float, rotation: Float, startAngle: Float, endAngle: Float, anticlockwise: Bool) {
        path = native_path_2d_ellipse(path, x, y, radiusX, radiusY, rotation, startAngle, endAngle, anticlockwise)
    }
    
    public func rect(x: Float, y: Float, width: Float, height: Float) {
        path = native_path_2d_rect(path, x, y, width, height)
    }
    
}

