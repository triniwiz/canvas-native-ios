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
                    let components = cgColor.components ?? []
                    let count = cgColor.numberOfComponents
                    var r = UInt8(0)
                    
                    if (count > 2) {
                        var red = components[0] * 255
                        if red > 255 {
                            red = 255
                        }
                        r = UInt8(red)
                    }
                    var g = UInt8(0)
                    if (count > 2){
                        var green = components[1] * 255
                        if green > 255 {
                            green = 255
                        }
                        g = UInt8(green)
                    }
                    var b = UInt8(0)
                    if (count > 2){
                        var blue = components[2] * 255
                        if blue > 255 {
                            blue = 255
                        }
                        b = UInt8(blue)
                    }
                    var alpha = cgColor.alpha * 255
                    if alpha > 255 {
                        alpha = 255
                    }
                    let a = UInt8(alpha)
                    
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
                    let components = cgColor.components ?? []
                    let count = cgColor.numberOfComponents
                    var r = UInt8(0)
                    
                    if (count > 2) {
                        var red = components[0] * 255
                        if red > 255 {
                            red = 255
                        }
                        r = UInt8(red)
                    }
                    var g = UInt8(0)
                    if (count > 2){
                        var green = components[1] * 255
                        if green > 255 {
                            green = 255
                        }
                        g = UInt8(green)
                    }
                    var b = UInt8(0)
                    if (count > 2){
                        var blue = components[2] * 255
                        if blue > 255 {
                            blue = 255
                        }
                        b = UInt8(blue)
                    }
                    var alpha = cgColor.alpha * 255
                    if alpha > 255 {
                        alpha = 255
                    }
                    let a = UInt8(alpha)
                    
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
            let currentContext = Canvas.currentContext()
            if currentContext != nil && currentContext != canvas.context {
                let _ = canvas.ensureIsContextIsCurrent()
            }
            canvas.canvas = native_fill_rect(canvas.canvas, x, y, width, height)
            
        }
        
        public func strokeRect(x: Float, y: Float, width: Float, height: Float) {
            let currentContext = Canvas.currentContext()
            if currentContext != nil && currentContext != canvas.context {
                let _ = canvas.ensureIsContextIsCurrent()
            }
            canvas.canvas = native_stroke_rect(canvas.canvas, x, y, width, height)
            
        }
        
        public func fillText(text: String, x: Float, y:Float) {
            fillText(text: text, x: x, y: y, width: 0)
        }
        
        public func fillText(text: String, x: Float, y:Float, width: Float) {
            let currentContext = Canvas.currentContext()
            if currentContext != nil && currentContext != canvas.context {
                let _ = canvas.ensureIsContextIsCurrent()
            }
            canvas.canvas = native_fill_text(canvas.canvas, text, x, y, width)
            
        }
        
        public func strokeText(text: String, x: Float, y:Float) {
            strokeText(text: text, x: x, y: y, width: 0)
            
        }
        
        public func strokeText(text: String, x: Float, y:Float, width: Float) {
            let currentContext = Canvas.currentContext()
            if currentContext != nil && currentContext != canvas.context {
                let _ = canvas.ensureIsContextIsCurrent()
            }
            canvas.canvas = native_stroke_text(canvas.canvas, text, x, y, width)
            
        }
        
        public func rect(x: Float, y: Float, width: Float, height: Float) {
            canvas.canvas = native_rect(canvas.canvas, x, y, width, height)
        }
        
        public func fill() {
            let currentContext = Canvas.currentContext()
            if currentContext != nil && currentContext != canvas.context {
                let _ = canvas.ensureIsContextIsCurrent()
            }
            canvas.canvas = native_fill(canvas.canvas)
            
        }
        
        public func stroke() {
            let currentContext = Canvas.currentContext()
            if currentContext != nil && currentContext != canvas.context {
                let _ = canvas.ensureIsContextIsCurrent()
            }
            canvas.canvas = native_stroke(canvas.canvas)
            
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
            ellipse(x: x, y: y, radiusX: radiusX, radiusY: radiusY, rotation: rotation, startAngle: startAngle, endAngle: endAngle, anticlockwise: false);
        }
        
        public func ellipse(x: Float, y: Float, radiusX: Float, radiusY: Float, rotation: Float, startAngle: Float, endAngle: Float, anticlockwise: Bool) {
            canvas.canvas = native_ellipse(canvas.canvas, x, y, radiusX, radiusY, rotation, startAngle, endAngle, anticlockwise)
        }
        
        public func clip(rule: String?) {
            canvas.canvas = native_clip(canvas.canvas, rule ?? "nonzero")
        }
        
        public func clearRect(x: Float, y: Float, width: Float, height: Float){
            let currentContext = Canvas.currentContext()
            if currentContext != nil && currentContext != canvas.context {
                let _ = canvas.ensureIsContextIsCurrent()
            }
            canvas.canvas = native_clear_rect(canvas.canvas, x, y, width, height)
            
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
            let currentContext = Canvas.currentContext()
            if currentContext != nil && currentContext != canvas.context {
                let _ = canvas.ensureIsContextIsCurrent()
            }
            canvas.canvas = native_set_transform(canvas.canvas, a, b, c, d, e, f)
            
        }
        
        public func scale(x: Float, y: Float){
            let currentContext = Canvas.currentContext()
            if currentContext != nil && currentContext != canvas.context {
                let _ = canvas.ensureIsContextIsCurrent()
            }
            canvas.canvas = native_scale(canvas.canvas, x, y)
            
        }
        
        public func rotate(angle: Float){
            let currentContext = Canvas.currentContext()
            if currentContext != nil && currentContext != canvas.context {
                let _ = canvas.ensureIsContextIsCurrent()
            }
            canvas.canvas = native_rotate(canvas.canvas, angle)
            
        }
        
        public func translate(x: Float, y: Float){
            let currentContext = Canvas.currentContext()
            if currentContext != nil && currentContext != canvas.context {
                let _ = canvas.ensureIsContextIsCurrent()
            }
            canvas.canvas = native_translate(canvas.canvas, x, y)
            
        }
        
        public func quadraticCurveTo(cpx: Float, cpy: Float, x: Float, y: Float){
            canvas.canvas = native_quadratic_curve_to(canvas.canvas, cpx, cpy, x, y)
        }
        
        public func drawImage(image: UIImage, dx: Float, dy: Float){
            let currentContext = Canvas.currentContext()
            if currentContext != nil && currentContext != canvas.context {
                let _ = canvas.ensureIsContextIsCurrent()
            }
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
                canvas.canvas = native_draw_image(canvas.canvas, &byteArray, count, Int32(width),Int32(height), dx, dy)
                
            }
        }
        
        public func drawImage(image: UIImage, dx: Float, dy: Float, dWidth: Float, dHeight: Float){
            let currentContext = Canvas.currentContext()
            if currentContext != nil && currentContext != canvas.context {
                let _ = canvas.ensureIsContextIsCurrent()
            }
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
                canvas.canvas = native_draw_image_dw(canvas.canvas, &byteArray, data.count,Int32(width),Int32(height), dx, dy,dWidth,dHeight)
            }
        }
        
        
        public func drawImage(image: UIImage, sx: Float, sy: Float, sWidth: Float, sHeight: Float, dx: Float, dy: Float, dWidth: Float, dHeight: Float){
            let currentContext = Canvas.currentContext()
            if currentContext != nil && currentContext != canvas.context {
                let _ = canvas.ensureIsContextIsCurrent()
            }
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
                canvas.canvas = native_draw_image_sw(canvas.canvas, &byteArray, data.count, Int32(width), Int32(height), sx, sy,sWidth, sHeight, dx, dy, dWidth, dHeight)
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
    }
