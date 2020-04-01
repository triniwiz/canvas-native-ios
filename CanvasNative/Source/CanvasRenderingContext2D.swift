    //
    //  CanvasRenderingContext2D.swift
    //
    //  Created by Osei Fortune on 7/15/19.
    //  Copyright © 2019 Osei Fortune. All rights reserved.
    //
    
    import Foundation
    import UIKit
    
    public class CanvasRenderingContext2D: CanvasRenderingContext {
        var canvas: Canvas
        private var _fillStyle: ICanvasColorStyle = CanvasColorStyle.Color(color: .black)
        private var _strokeStyle: ICanvasColorStyle = CanvasColorStyle.Color(color: .black)
        private var _lineWidth: Float = 1
        private var _globalCompositeOperation = CanvasCompositeOperationType.SourceOver
        private var _font = "10px sans-serif"
        private var _globalAlpha:Float = 1
        public init(canvas: Canvas) {
            self.canvas = canvas
        }
        
        public var font: String {
            get {
                return _font
            }
            set {
                canvas.canvas = native_set_font(canvas.canvas, newValue)
                _font = newValue
            }
        }
        
        public var globalAlpha: Float {
            get{
                return _globalAlpha
            }
            set {
                var val = newValue
                if(val > 1.0){
                    val = 1.0
                }
                canvas.canvas = native_set_global_alpha(canvas.canvas, UInt8(val * 255))
                _globalAlpha = val
            }
        }
        
        public var globalCompositeOperation:CanvasCompositeOperationType {
            set {
                canvas.canvas = native_set_global_composite_operation(canvas.canvas, newValue.rawValue)
                _globalCompositeOperation = newValue
            }
            get {
                return _globalCompositeOperation
            }
        }
        private var _imageSmoothingEnabled: Bool = false
        public var imageSmoothingEnabled: Bool {
            get {
                return _imageSmoothingEnabled
            }
            set {
                canvas.canvas = native_image_smoothing_enabled(canvas.canvas, newValue)
                _imageSmoothingEnabled = newValue
            }
        }
        
        private var _imageSmoothingQuality: ImageSmoothingQuality = .Low
        public var imageSmoothingQuality: ImageSmoothingQuality {
            get {
                return _imageSmoothingQuality
            }
            set {
                let val = newValue.rawValue
                
                canvas.canvas = native_image_smoothing_quality(canvas.canvas, val)
            }
        }
        
        private var _lineCap = LineCap.Butt
        public var lineCap: LineCap {
            get {
                return _lineCap
            }
            set {
                canvas.canvas = native_set_line_cap(canvas.canvas, newValue.rawValue)
                _lineCap = newValue
            }
        }
        
        private var _lineDashOffset: Float = 0
        
        public var lineDashOffset: Float {
            get {
                return _lineDashOffset
            }
            set {
                canvas.canvas = native_line_dash_offset(canvas.canvas, newValue)
                _lineDashOffset = newValue
            }
        }
        public var lineWidth: Float {
            get {
                return _lineWidth
            }
            set {
                canvas.canvas =  native_set_line_width(canvas.canvas, newValue)
                _lineWidth = newValue
            }
        }
        
        private var _lineJoin: LineJoin = .Miter
        public var lineJoin: LineJoin {
            get {
                return _lineJoin
            }
            set {
                canvas.canvas = native_line_join(canvas.canvas, newValue.rawValue)
                _lineJoin = newValue
            }
        }
        private var _miterLimit: Float = 10
        
        public var miterLimit: Float {
            get {
                return _miterLimit
            }
            set {
                canvas.canvas = native_miter_limit(canvas.canvas, newValue)
                _miterLimit = newValue
            }
        }
        
        private var _shadowBlur: Float = 0
        public var shadowBlur: Float {
            get {
                return _shadowBlur
            }
            set {
                canvas.canvas = native_shadow_blur(canvas.canvas, newValue)
                _shadowBlur = newValue
            }
        }
        private var _shadowColor: UIColor = .clear
        public var shadowColor: UIColor {
            get {
                return _shadowColor
            }
            set {
                canvas.canvas = native_shadow_color(canvas.canvas, UInt32(newValue.colorCode))
                _shadowColor = newValue
            }
        }
        private var _shadowOffsetX: Float = 0
        public var shadowOffsetX: Float{
            get {
                return _shadowOffsetX
            }
            set {
                canvas.canvas = native_shadow_offset_x(canvas.canvas, newValue)
                _shadowOffsetX = newValue
            }
        }
        
        private var _shadowOffsetY: Float = 0
        public var shadowOffsetY: Float {
            get {
                return _shadowOffsetY
            }
            set {
                canvas.canvas = native_shadow_offset_y(canvas.canvas, newValue)
                _shadowOffsetY = newValue
            }
        }
        
        
        
        private var _textAlign: TextAlignment = TextAlignment.Left
        public var textAlign: TextAlignment{
            get {
                return _textAlign
            }
            set {
                var val = newValue.rawValue
                switch newValue {
                case .Start:
                    val = "left"
                case .End:
                    val = "right"
                default: break
                }
                canvas.canvas = native_text_align(canvas.canvas, val)
                _textAlign = newValue
            }
        }
        public var fillStyle: ICanvasColorStyle {
            get {
                return _fillStyle
            }
            set {
                switch newValue.getStyleType() {
                case .Color:
                    let fill = newValue as! CanvasColorStyle.Color
                    let cgColor = fill.color.cgColor
                    let components = cgColor.components
                    let count = components?.count ?? 0
                    var r = UInt8(0)
                    var g = UInt8(0)
                    var b = UInt8(0)
                    var a = UInt8(255)
                    if(count > 0){
                        r = UInt8((components?[0] ?? 0) * 255.0)
                        if(count == 2){
                            g = r
                            b = r
                        }
                    }
                    if(count > 2){
                        if(count > 1){
                            g = UInt8((components?[1] ?? 0) * 255.0)
                        }
                        
                        if(count > 2){
                            b = UInt8((components?[2] ?? 0) * 255.0)
                        }
                        if(count > 3){
                            a = UInt8((components?[3] ?? 0) * 255.0)
                        }
                    }
                    canvas.canvas = native_set_fill_color_rgba(canvas.canvas, r, g, b, a)
                    _fillStyle = newValue
                case .Gradient:
                    let isLinear = newValue as? CanvasColorStyle.LinearGradient
                    let isRadial = newValue as? CanvasColorStyle.RadialGradient
                    if isLinear != nil {
                        canvas.canvas = native_set_fill_gradient_linear(canvas.canvas,
                                                                        isLinear!.x0,
                                                                        isLinear!.y0,
                                                                        isLinear!.x1,
                                                                        isLinear!.y1,
                                                                        (isLinear?.getColors().count)!,
                                                                        isLinear?.getColors(),
                                                                        (isLinear?.getPostions().count)!,
                                                                        isLinear?.getPostions())
                    }else if isRadial != nil{
                        canvas.canvas = native_set_fill_gradient_radial(
                            canvas.canvas,
                            isRadial!.x0,
                            isRadial!.y0,
                            isRadial!.r0,
                            isRadial!.x1,
                            isRadial!.y1,
                            isRadial!.r1,
                            (isRadial?.getColors().count)!,
                            isRadial?.getColors(),
                            (isRadial?.getPostions().count)!,
                            isRadial?.getPostions()
                        )
                    }
                case .Pattern:
                    _ = ""
                }
            }
        }
        
        
        
        
        public var strokeStyle: ICanvasColorStyle {
            get {
                return _strokeStyle
            }
            set {
                switch newValue.getStyleType() {
                case .Color:
                    let fill = newValue as! CanvasColorStyle.Color
                    let cgColor = fill.color.cgColor
                    let components = cgColor.components
                    let count = components?.count ?? 0
                    var r = UInt8(0)
                    var g = UInt8(0)
                    var b = UInt8(0)
                    var a = UInt8(255)
                    if(count > 0){
                        r = UInt8((components?[0] ?? 0) * 255.0)
                        if(count == 2){
                            g = r
                            b = r
                        }
                    }
                    if(count > 2){
                        if(count > 1){
                            g = UInt8((components?[1] ?? 0) * 255.0)
                        }
                        
                        if(count > 2){
                            b = UInt8((components?[2] ?? 0) * 255.0)
                        }
                        if(count > 3){
                            a = UInt8((components?[3] ?? 0) * 255.0)
                        }
                    }
                    canvas.canvas = native_set_stroke_color_rgba(canvas.canvas, r, g, b, a)
                    _strokeStyle = newValue
                case .Gradient:
                    let isLinear = newValue as? CanvasColorStyle.LinearGradient
                    let isRadial = newValue as? CanvasColorStyle.RadialGradient
                    if isLinear != nil {
                        canvas.canvas = native_set_stroke_gradient_linear(canvas.canvas,
                                                                          isLinear!.x0,
                                                                          isLinear!.y0,
                                                                          isLinear!.x1,
                                                                          isLinear!.y1,
                                                                          (isLinear?.getColors().count)!,
                                                                          isLinear?.getColors(),
                                                                          (isLinear?.getPostions().count)!,
                                                                          isLinear?.getPostions())
                    }else if isRadial != nil{
                        canvas.canvas = native_set_stroke_gradient_radial(
                            canvas.canvas,
                            isRadial!.x0,
                            isRadial!.y0,
                            isRadial!.r0,
                            isRadial!.x1,
                            isRadial!.y1,
                            isRadial!.r1,
                            (isRadial?.getColors().count)!,
                            isRadial?.getColors(),
                            (isRadial?.getPostions().count)!,
                            isRadial?.getPostions()
                        )
                    }
                case .Pattern:
                    _ = ""
                }
            }
        }
        
        public func fillRect(x: Float, y: Float, width: Float, height: Float) {
            self.canvas.canvas = native_fill_rect(self.canvas.canvas, x, y, width, height, self.canvas.getViewPtr())
            self.canvas.doDraw()
        }
        
        public func strokeRect(x: Float, y: Float, width: Float, height: Float) {
            
            canvas.canvas = native_stroke_rect(canvas.canvas, x, y, width, height,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func fillText(text: String, x: Float, y:Float) {
            fillText(text: text, x: x, y: y, width: 0)
        }
        
        public func fillText(text: String, x: Float, y:Float, width: Float) {
            
            canvas.canvas = native_fill_text(canvas.canvas, text, x, y, width,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func strokeText(text: String, x: Float, y:Float) {
            strokeText(text: text, x: x, y: y, width: 0)
        }
        
        public func strokeText(text: String, x: Float, y:Float, width: Float) {
            
            canvas.canvas = native_stroke_text(canvas.canvas, text, x, y, width,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func rect(x: Float, y: Float, width: Float, height: Float) {
            canvas.canvas = native_rect(canvas.canvas, x, y, width, height)
        }
        
        public func fill() {
            canvas.canvas = native_fill(canvas.canvas,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func fill(rule: String) {
            
            canvas.canvas = native_fill_rule(canvas.canvas,rule,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func fill(path: CanvasPath2D) {
            
            canvas.canvas = native_fill_path_rule(canvas.canvas,path.path,"",self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func fill(path: CanvasPath2D, rule: String) {
            
            canvas.canvas = native_fill_path_rule(canvas.canvas,path.path,rule,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func stroke() {
            
            canvas.canvas = native_stroke(canvas.canvas,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func stroke(path: CanvasPath2D) {
            
            canvas.canvas = native_stroke_path(canvas.canvas,path.path,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func beginPath() {
            canvas.canvas = native_begin_path(canvas.canvas)
        }
        
        public func moveTo(x: Float, y: Float) {
            canvas.canvas = native_move_to(canvas.canvas, x, y)
        }
        
        public func lineTo(x: Float, y: Float) {
            canvas.canvas = native_line_to(canvas.canvas, x, y)
        }
        
        public func closePath() {
            canvas.canvas = native_close_path(canvas.canvas)
        }
        
        public func arc(x: Float, y: Float, radius: Float, startAngle: Float, endAngle: Float) {
            arc(x: x, y: y, radius: radius, startAngle: startAngle, endAngle: endAngle, anticlockwise: false);
        }
        
        public func arc(x: Float, y: Float, radius: Float, startAngle: Float, endAngle: Float, anticlockwise: Bool) {
            canvas.canvas = native_arc(canvas.canvas, x, y, radius, startAngle, endAngle, anticlockwise)
        }
        
        public func arcTo(x1: Float, y1: Float, x2: Float, y2: Float, radius: Float) {
            canvas.canvas = native_arc_to(canvas.canvas, x1, y1, x2, y2, radius)
        }
        
        public func bezierCurveTo(cp1x: Float, cp1y: Float, cp2x: Float, cp2y: Float, x: Float, y: Float) {
            canvas.canvas = native_bezier_curve_to(canvas.canvas, cp1x, cp1y, cp2x, cp2y, x, y)
        }
        
        public func ellipse(x: Float, y: Float, radiusX: Float, radiusY: Float, rotation: Float, startAngle: Float, endAngle: Float) {
            ellipse(x: x, y: y, radiusX: radiusX, radiusY: radiusY, rotation: rotation, startAngle: startAngle, endAngle: endAngle, anticlockwise: false)
        }
        
        public func ellipse(x: Float, y: Float, radiusX: Float, radiusY: Float, rotation: Float, startAngle: Float, endAngle: Float, anticlockwise: Bool) {
            canvas.canvas = native_ellipse(canvas.canvas, x, y, radiusX, radiusY, rotation, startAngle, endAngle, anticlockwise)
        }
        
        public func clip(){
            canvas.canvas = native_clip(canvas.canvas,self.canvas.getViewPtr())
        }
        public func clip(rule: String) {
            canvas.canvas = native_clip_rule(canvas.canvas, rule,self.canvas.getViewPtr())
        }
        
        public func clip(path:CanvasPath2D , rule: String ) {
            canvas.canvas = native_clip_path_rule(canvas.canvas, path.path,rule,self.canvas.getViewPtr())
        }
        
        public func clip(path:CanvasPath2D) {
            clip(path: path, rule: "nonzero")
        }
        
        public func clearRect(x: Float, y: Float, width: Float, height: Float){
            canvas.canvas = native_clear_rect(canvas.canvas, x, y, width, height,self.canvas.getViewPtr())
            canvas.doDraw()
            
        }
        private var _lineDashSegments: [Float32] = []
        public func setLineDash(segments: [Float32]){
            var array: [Float32] = []
            array.append(contentsOf: segments)
            canvas.canvas = native_set_line_dash(canvas.canvas, segments.count, &array)
            _lineDashSegments = segments
        }
        
        public func getCanvas() -> Canvas {
            return canvas
        }
        
        
        public func createLinearGradient(x0: Float, y0: Float, x1: Float,y1: Float) -> CanvasColorStyle.LinearGradient {
            return CanvasColorStyle.LinearGradient(x0: x0, y0: y0, x1: x1, y1: y1);
        }
        
        public func createRadialGradient(x0: Float, y0: Float, r0: Float, x1: Float, y1: Float, r1: Float) -> CanvasColorStyle.RadialGradient {
            return CanvasColorStyle.RadialGradient(x0: x0, y0: y0, r0: r0, x1: x1, y1: y1, r1: r1);
        }
        
        public func createPattern(src: AnyObject, repetition: PatternRepetition) -> CanvasColorStyle.Pattern {
            return CanvasColorStyle.Pattern(src: src, pattern: repetition);
        }
        
        public func setTransform(a: Float, b: Float, c: Float, d: Float, e: Float, f: Float){
            canvas.canvas = native_set_transform(canvas.canvas, a, b, c, d, e, f,self.canvas.getViewPtr())
            canvas.doDraw()
            
        }
        
        public func scale(x: Float, y: Float){
            canvas.canvas = native_scale(canvas.canvas, x, y,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func rotate(angle: Float){
            canvas.canvas = native_rotate(canvas.canvas, angle,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func translate(x: Float, y: Float){
            canvas.canvas = native_translate(canvas.canvas, x, y,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func quadraticCurveTo(cpx: Float, cpy: Float, x: Float, y: Float){
            canvas.canvas = native_quadratic_curve_to(canvas.canvas, cpx, cpy, x, y)
        }
        
        public func drawImage(image: UIImage, dx: Float, dy: Float){
            
            let cgRef = image.cgImage
            var data = image.pngData() ?? Data()
            let width = cgRef?.width ?? 0
            let height = cgRef?.height ?? 0
            let bitsPerComponent = cgRef?.bitsPerComponent ?? 0
            let bytesPerRow = Int(width * 4)
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipFirst.rawValue)
            let context = CGContext(data: &data, width:width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
            if context != nil {
                
                let count = data.count / MemoryLayout<UInt8>.size
                // create an array of Uint8
                var byteArray = [UInt8](repeating: 0, count: count)
                // copy bytes into array
                
                data.copyBytes(to: &byteArray, count: count)
                canvas.canvas = native_draw_image(canvas.canvas, &byteArray, count, Int32(width),Int32(height), dx, dy,self.canvas.getViewPtr())
                canvas.doDraw()
            }
        }
        
        public func drawImage(image: UIImage, dx: Float, dy: Float, dWidth: Float, dHeight: Float){
            let cgRef = image.cgImage
            var data = image.pngData() ?? Data()
            let width = cgRef?.width ?? 0
            let height = cgRef?.height ?? 0
            let bitsPerComponent = cgRef?.bitsPerComponent ?? 0
            let bytesPerRow = Int(width * 4)
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipFirst.rawValue)
            let context = CGContext(data: &data, width:width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
            if context != nil {
                let count = data.count / MemoryLayout<UInt8>.size
                
                // create an array of Uint8
                var byteArray = [UInt8](repeating: 0, count: count)
                // copy bytes into array
                
                data.copyBytes(to: &byteArray, count: count)
                canvas.canvas = native_draw_image_dw(canvas.canvas, &byteArray, data.count,Int32(width),Int32(height), dx, dy,dWidth,dHeight,self.canvas.getViewPtr())
                canvas.doDraw()
            }
        }
        
        
        public func drawImage(image: UIImage, sx: Float, sy: Float, sWidth: Float, sHeight: Float, dx: Float, dy: Float, dWidth: Float, dHeight: Float){
            
            let cgRef = image.cgImage
            var data = image.pngData() ?? Data()
            let width = cgRef?.width ?? 0
            let height = cgRef?.height ?? 0
            let bitsPerComponent = cgRef?.bitsPerComponent ?? 0
            let bytesPerRow = Int(width * 4)
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipFirst.rawValue)
            let context = CGContext(data: &data, width:width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)
            if context != nil {
                let count = data.count / MemoryLayout<UInt8>.size
                
                // create an array of Uint8
                var byteArray = [UInt8](repeating: 0, count: count)
                // copy bytes into array
                
                data.copyBytes(to: &byteArray, count: count)
                canvas.canvas = native_draw_image_sw(canvas.canvas, &byteArray, data.count, Int32(width), Int32(height), sx, sy,sWidth, sHeight, dx, dy, dWidth, dHeight,self.canvas.getViewPtr())
                canvas.doDraw()
            }
            
        }
        
        public func createImageData(width: Int, height: Int)-> ImageData{
            return ImageData(width: width, height: height)
        }
        
        public func createImageData(imageData: ImageData)-> ImageData{
            return ImageData(width: imageData.width, height: imageData.height)
        }
        
        public func getImageData(sx: Float, sy: Float, sw:Int, sh:Int) -> ImageData{
            let nativeData = native_get_image_data(canvas.canvas, sx, sy, sw, sh)
            let data = Data(bytes: nativeData.array, count: nativeData.length)
            native_drop_image_data(nativeData)
            return ImageData(width:sw , height: sh, data: data)
        }
        
        
        public func putImageData(imageData: ImageData, dx: Float, dy: Float){
            putImageData(imageData: imageData, dx: dx, dy: dy, dirtyX: 0, dirtyY: 0, dirtyWidth: -1, dirtyHeight: -1)
        }
        
        public func putImageData(imageData: ImageData, dx: Float, dy: Float, dirtyX: Float, dirtyY: Float, dirtyWidth:Int, dirtyHeight: Int){
            
            let count = imageData.data.count / MemoryLayout<UInt8>.size
            
            // create an array of Uint8
            var byteArray = [UInt8](repeating: 0, count: count)
            // copy bytes into array
            
            imageData.data.copyBytes(to: &byteArray, count: count)
            
            canvas.canvas = native_put_image_data(canvas.canvas, imageData.width, imageData.height, &byteArray, count, dx, dy, dirtyX, dirtyY, dirtyWidth, dirtyHeight)
            canvas.doDraw()
            
        }
        
        public func getLineDash() -> [Float32]{
            return _lineDashSegments
        }
        
        public func save() {
            canvas.canvas = native_save(canvas.canvas)
        }
        
        public func restore() {
            canvas.canvas = native_restore(canvas.canvas)
        }
        
        public func measureText(text: String) -> TextMetrics {
            let data = native_measure_text(canvas.canvas, text)
            return TextMetrics(metrics: data)
        }
        public func resetTransform(){
            canvas.canvas = native_reset_transform(canvas.canvas)
            canvas.doDraw()
        }
        
        public func transform(a: Float, b: Float, c: Float, d: Float, e: Float, f: Float){
            canvas.canvas = native_transform(canvas.canvas, a, b, c, d, e, f,self.canvas.getViewPtr())
            canvas.doDraw()
        }
    }
