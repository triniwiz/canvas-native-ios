    //
    //  CanvasRenderingContext2D.swift
    //
    //  Created by Osei Fortune on 7/15/19.
    //  Copyright © 2019 Osei Fortune. All rights reserved.
    //
    
    import Foundation
    import UIKit
    @objcMembers
    @objc(CanvasRenderingContext2D)
    public class CanvasRenderingContext2D: CanvasRenderingContext {
        var canvas: Canvas
        private var _fillStyle: Any = CanvasColorStyle.Color(color: .black)
        private var _strokeStyle: Any = CanvasColorStyle.Color(color: .black)
        private var _lineWidth: Float = 1
        private var _globalCompositeOperation = CanvasCompositeOperationType.SourceOver
        private var _font = "10px sans-serif"
        private var _globalAlpha:Float = 1
        
        func ensureIsContextIsCurrent() -> Bool {
            return canvas.renderer?.ensureIsContextIsCurrent() ?? false
        }
        public init(canvas: Canvas) {
            self.canvas = canvas
            let _ = (canvas.renderer as? GLRenderer)?.ensureIsContextIsCurrent()
        }
        
        public var currentTransform: CanvasDOMMatrix {
            get {
                let matrix = native_get_current_transform(canvas.canvas)
                if(matrix == 0){
                    return CanvasDOMMatrix()
                }
                return CanvasDOMMatrix(matrix: matrix)
            }
            set {
                native_set_current_transform(canvas.canvas, newValue.matrix)
            }
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
        private var _shadowColor: Any = UIColor.clear
        public var shadowColor: Any {
            get {
                return _shadowColor
            }
            set {
                if let color = newValue as? UIColor {
                    canvas.canvas = native_shadow_color(canvas.canvas, UInt32(color.colorCode))
                    _shadowColor = newValue
                }else if let colorCode = newValue as? UInt32 {
                    canvas.canvas = native_shadow_color(canvas.canvas, colorCode)
                    _shadowColor = newValue
                }
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
        
        public var fillStyle: Any {
            get {
                return _fillStyle
            }
            set {
                if let style = newValue as? ICanvasColorStyle {
                    switch style.getStyleType() {
                    case .Color:
                        let fill = newValue as! CanvasColorStyle.Color
                        if let current = _fillStyle as? CanvasColorStyle.Color{
                            if(current.color.isSame(fill.color)){
                                return
                            }
                        }
                        if(!fill.color.isCached){
                            fill.color.cacheColor()
                        }
                        canvas.canvas = native_set_fill_color_rgba(canvas.canvas, fill.color.red, fill.color.green, fill.color.blue, fill.color.alpha)
                        _fillStyle = fill
                    case .Gradient:
                        if let isLinear = newValue as? CanvasColorStyle.LinearGradient {
                            canvas.canvas = native_set_fill_gradient_linear(canvas.canvas,
                                                                            isLinear.x0,
                                                                            isLinear.y0,
                                                                            isLinear.x1,
                                                                            isLinear.y1,
                                                                            isLinear.getColors().count,
                                                                            isLinear.getColors(),
                                                                            isLinear.getPostions().count,
                                                                            isLinear.getPostions())
                            _fillStyle = isLinear
                        }
                        if let isRadial = newValue as? CanvasColorStyle.RadialGradient {
                            canvas.canvas = native_set_fill_gradient_radial(
                                canvas.canvas,
                                isRadial.x0,
                                isRadial.y0,
                                isRadial.r0,
                                isRadial.x1,
                                isRadial.y1,
                                isRadial.r1,
                                isRadial.getColors().count,
                                isRadial.getColors(),
                                isRadial.getPostions().count,
                                isRadial.getPostions()
                            )
                            _fillStyle = isRadial
                        }
                    case .Pattern:
                        if let pattern = newValue as? CanvasColorStyle.Pattern{
                            canvas.canvas = native_set_fill_pattern(canvas.canvas, pattern.nativePattern)
                            _fillStyle = pattern
                        }
                    }
                }else if let color = newValue as? UInt32 {
                    canvas.canvas = native_set_fill_color(canvas.canvas, color)
                    _fillStyle = color
                } else if let color = newValue as? String {
                    let c = UIColor(fromString: color)
                    canvas.canvas = native_set_fill_color_rgba(canvas.canvas, c.alpha, c.green, c.blue, c.alpha)
                    _fillStyle = color
                }
            }
        }
        
        
        
        
        public var strokeStyle: Any {
            get {
                return _strokeStyle
            }
            set {
                if let color = newValue as? UInt32 {
                    canvas.canvas = native_set_stroke_color(canvas.canvas, color)
                } else if let color = newValue as? String {
                    let c = UIColor(fromString: color)
                    canvas.canvas = native_set_stroke_color_rgba(canvas.canvas, c.alpha, c.green, c.blue, c.alpha)
                    _fillStyle = color
                }else if let style = newValue as? ICanvasColorStyle {
                    switch style.getStyleType() {
                    case .Color:
                        let fill = newValue as! CanvasColorStyle.Color
                        if let current = _strokeStyle as? CanvasColorStyle.Color{
                            if(current.color.isSame(fill.color)){
                                return
                            }
                        }
                        if(!fill.color.isCached){
                            fill.color.cacheColor()
                        }
                        canvas.canvas = native_set_stroke_color_rgba(canvas.canvas, fill.color.red, fill.color.green, fill.color.blue, fill.color.alpha)
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
                        _strokeStyle = newValue
                    case .Pattern:
                        let pattern = newValue as! CanvasColorStyle.Pattern
                        canvas.canvas = native_set_stroke_pattern(canvas.canvas, pattern.nativePattern)
                        _strokeStyle = newValue
                    }
                }
            }
        }
        
        public func fillRect(x: Float, y: Float, width: Float, height: Float) {
            let _ = ensureIsContextIsCurrent()
            self.canvas.canvas = native_fill_rect(self.canvas.canvas, x, y, width, height, self.canvas.getViewPtr())
            self.canvas.doDraw()
        }
        
        public func strokeRect(x: Float, y: Float, width: Float, height: Float) {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_stroke_rect(canvas.canvas, x, y, width, height,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func fillText(text: String, x: Float, y:Float) {
            let _ = ensureIsContextIsCurrent()
            fillText(text: text, x: x, y: y, width: 0)
        }
        
        public func fillText(text: String, x: Float, y:Float, width: Float) {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_fill_text(canvas.canvas, text, x, y, width,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func strokeText(text: String, x: Float, y:Float) {
            let _ = ensureIsContextIsCurrent()
            strokeText(text: text, x: x, y: y, width: 0)
        }
        
        public func strokeText(text: String, x: Float, y:Float, width: Float) {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_stroke_text(canvas.canvas, text, x, y, width,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func rect(x: Float, y: Float, width: Float, height: Float) {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_rect(canvas.canvas, x, y, width, height)
        }
        
        public func fill() {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_fill(canvas.canvas,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func fill(rule: String) {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_fill_rule(canvas.canvas,rule,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func fill(path: CanvasPath2D) {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_fill_path_rule(canvas.canvas,path.path,"",self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func fill(path: CanvasPath2D, rule: String) {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_fill_path_rule(canvas.canvas,path.path,rule,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func stroke() {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_stroke(canvas.canvas,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func stroke(path: CanvasPath2D) {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_stroke_path(canvas.canvas,path.path,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func beginPath() {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_begin_path(canvas.canvas)
        }
        
        public func moveTo(x: Float, y: Float) {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_move_to(canvas.canvas, x, y)
        }
        
        public func lineTo(x: Float, y: Float) {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_line_to(canvas.canvas, x, y)
        }
        
        public func closePath() {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_close_path(canvas.canvas)
        }
        
        public func arc(x: Float, y: Float, radius: Float, startAngle: Float, endAngle: Float) {
            let _ = ensureIsContextIsCurrent()
            arc(x: x, y: y, radius: radius, startAngle: startAngle, endAngle: endAngle, anticlockwise: false);
        }
        
        public func arc(x: Float, y: Float, radius: Float, startAngle: Float, endAngle: Float, anticlockwise: Bool) {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_arc(canvas.canvas, x, y, radius, startAngle, endAngle, anticlockwise)
        }
        
        public func arcTo(x1: Float, y1: Float, x2: Float, y2: Float, radius: Float) {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_arc_to(canvas.canvas, x1, y1, x2, y2, radius)
        }
        
        public func bezierCurveTo(cp1x: Float, cp1y: Float, cp2x: Float, cp2y: Float, x: Float, y: Float) {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_bezier_curve_to(canvas.canvas, cp1x, cp1y, cp2x, cp2y, x, y)
        }
        
        public func ellipse(x: Float, y: Float, radiusX: Float, radiusY: Float, rotation: Float, startAngle: Float, endAngle: Float) {
            let _ = ensureIsContextIsCurrent()
            ellipse(x: x, y: y, radiusX: radiusX, radiusY: radiusY, rotation: rotation, startAngle: startAngle, endAngle: endAngle, anticlockwise: false)
        }
        
        public func ellipse(x: Float, y: Float, radiusX: Float, radiusY: Float, rotation: Float, startAngle: Float, endAngle: Float, anticlockwise: Bool) {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_ellipse(canvas.canvas, x, y, radiusX, radiusY, rotation, startAngle, endAngle, anticlockwise)
        }
        
        public func clip(){
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_clip(canvas.canvas,self.canvas.getViewPtr())
        }
        public func clip(rule: String) {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_clip_rule(canvas.canvas, rule,self.canvas.getViewPtr())
        }
        
        public func clip(path:CanvasPath2D , rule: String ) {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_clip_path_rule(canvas.canvas, path.path,rule,self.canvas.getViewPtr())
        }
        
        public func clip(path:CanvasPath2D) {
            clip(path: path, rule: "nonzero")
        }
        
        public func clearRect(x: Float, y: Float, width: Float, height: Float){
            let _ = ensureIsContextIsCurrent()
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
        
        public func drawImage(canvas : Canvas, dx: Float, dy: Float){
            var ss = canvas.snapshot()
            let _ = ensureIsContextIsCurrent()
            self.canvas.canvas = native_draw_image(self.canvas.canvas, &ss, ss.count, Int32(canvas.width), Int32(canvas.height), dx, dy, self.canvas.getViewPtr())
            self.canvas.doDraw()
        }
        
        
        public func createPattern(canvas: Canvas, repetition: PatternRepetition) -> CanvasColorStyle.Pattern {
            return CanvasColorStyle.Pattern(canvas: canvas, pattern: repetition)
        }
        
        public func createPattern(src: UIImage, repetition: PatternRepetition) -> CanvasColorStyle.Pattern {
            return CanvasColorStyle.Pattern(src: src, pattern: repetition)
        }
        
        public func createPattern(asset src: ImageAsset, repetition: PatternRepetition) -> CanvasColorStyle.Pattern {
            return CanvasColorStyle.Pattern(asset: src, pattern: repetition)
        }
        
        
        public func setTransform(a: Float, b: Float, c: Float, d: Float, e: Float, f: Float){
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_set_transform(canvas.canvas, a, b, c, d, e, f,self.canvas.getViewPtr())
            canvas.doDraw()
            
        }
        
        public func scale(x: Float, y: Float){
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_scale(canvas.canvas, x, y,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func rotate(angle: Float){
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_rotate(canvas.canvas, angle,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func translate(x: Float, y: Float){
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_translate(canvas.canvas, x, y,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func quadraticCurveTo(cpx: Float, cpy: Float, x: Float, y: Float){
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_quadratic_curve_to(canvas.canvas, cpx, cpy, x, y)
        }
        
        public func drawImage(asset image: ImageAsset, dx: Float, dy: Float){
            let _ = ensureIsContextIsCurrent()
            let size = image.width * image.height * 4
            let width = image.width
            let height = image.height
            canvas.canvas = native_draw_image_raw(canvas.canvas, image.getRawBytes(), Int(size), Int32(width),Int32(height), dx, dy,self.canvas.getViewPtr())
            
            canvas.doDraw()
        }
        
        public func drawImage(image: UIImage, dx: Float, dy: Float){
            let _ = ensureIsContextIsCurrent()
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
                
                /*let count = data.count / MemoryLayout<UInt8>.size
                 // create an array of Uint8
                 var byteArray = [UInt8](repeating: 0, count: count)
                 // copy bytes into array
                 
                 data.copyBytes(to: &byteArray, count: count)
                 */
                var byteArray = [UInt8](data)
                canvas.canvas = native_draw_image(canvas.canvas, &byteArray, data.count, Int32(width),Int32(height), dx, dy,self.canvas.getViewPtr())
                canvas.doDraw()
            }
        }
        
        
        public func drawImage(asset image: ImageAsset, dx: Float, dy: Float, dWidth: Float, dHeight: Float){
            let _ = ensureIsContextIsCurrent()
            let size = image.width * image.height * 4
            let width = image.width
            let height = image.height
            
            canvas.canvas = native_draw_image_dw_raw(canvas.canvas, image.getRawBytes(), Int(size),Int32(width),Int32(height), dx, dy,dWidth,dHeight,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        
        public func drawImage(canvas: Canvas, dx: Float, dy: Float, dWidth: Float, dHeight: Float){
            let _ = ensureIsContextIsCurrent()
            var ss = canvas.snapshot()
            if let gl = self.canvas.renderer as? GLRenderer{
                let _ = gl.ensureIsContextIsCurrent()
            }
            self.canvas.canvas = native_draw_image_dw(self.canvas.canvas, &ss, ss.count, Int32(canvas.width), Int32(canvas.height), dx, dy, dWidth, dHeight, self.canvas.getViewPtr())
            self.canvas.doDraw()
        }
        
        
        public func drawImage(image: UIImage, dx: Float, dy: Float, dWidth: Float, dHeight: Float){
            let _ = ensureIsContextIsCurrent()
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
                /*let count = data.count / MemoryLayout<UInt8>.size
                 
                 // create an array of Uint8
                 var byteArray = [UInt8](repeating: 0, count: count)
                 // copy bytes into array
                 
                 data.copyBytes(to: &byteArray, count: count)
                 */
                var byteArray = [UInt8](data)
                canvas.canvas = native_draw_image_dw(canvas.canvas, &byteArray, data.count,Int32(width),Int32(height), dx, dy,dWidth,dHeight,self.canvas.getViewPtr())
                canvas.doDraw()
            }
        }
        
        public func drawImage(asset image: ImageAsset, sx: Float, sy: Float, sWidth: Float, sHeight: Float, dx: Float, dy: Float, dWidth: Float, dHeight: Float){
            let _ = ensureIsContextIsCurrent()
            let size = image.width * image.height * 4
            let width = image.width
            let height = image.height
            canvas.canvas = native_draw_image_sw_raw(canvas.canvas, image.getRawBytes(),Int(size), Int32(width), Int32(height), sx, sy,sWidth, sHeight, dx, dy, dWidth, dHeight,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        
        public func drawImage(canvas: Canvas, sx: Float, sy: Float, sWidth: Float, sHeight: Float, dx: Float, dy: Float, dWidth: Float, dHeight: Float){
            var ss = canvas.snapshot()
           let _ = ensureIsContextIsCurrent()
            self.canvas.canvas = native_draw_image_sw(self.canvas.canvas, &ss, ss.count, Int32(canvas.width), Int32(canvas.height), sx, sy, sWidth, sHeight, dx, dy, dWidth, dHeight, self.canvas.getViewPtr())
            self.canvas.doDraw()
        }
        
        
        public func drawImage(image: UIImage, sx: Float, sy: Float, sWidth: Float, sHeight: Float, dx: Float, dy: Float, dWidth: Float, dHeight: Float){
            let _ = ensureIsContextIsCurrent()
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
                var byteArray = [UInt8](data)
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
            let _ = ensureIsContextIsCurrent()
            let nativeData = native_get_image_data(canvas.canvas, sx, sy, sw, sh)
            let data = [UInt8](Data(bytes: nativeData.array, count: nativeData.length))
            native_drop_image_data(nativeData)
            return ImageData(width:sw , height: sh, data: data)
        }
        
        
        public func putImageData(imageData: ImageData, dx: Float, dy: Float){
            putImageData(imageData: imageData, dx: dx, dy: dy, dirtyX: 0, dirtyY: 0, dirtyWidth: -1, dirtyHeight: -1)
        }
        
        public func putImageData(imageData: ImageData, dx: Float, dy: Float, dirtyX: Float, dirtyY: Float, dirtyWidth:Int, dirtyHeight: Int){
            let _ = ensureIsContextIsCurrent()
            /*
             let count = imageData.data.count / MemoryLayout<UInt8>.size
             
             // create an array of Uint8
             var byteArray = [UInt8](repeating: 0, count: count)
             // copy bytes into array
             
             imageData.data.copyBytes(to: &byteArray, count: count)
             
             */
            
            var byteArray = [UInt8](imageData.data)
            canvas.canvas = native_put_image_data(canvas.canvas, imageData.width, imageData.height, &byteArray, byteArray.count, dx, dy, dirtyX, dirtyY, dirtyWidth, dirtyHeight)
            canvas.doDraw()
        }
        
        public func getLineDash() -> [Float32]{
            return _lineDashSegments
        }
        
        public func save() {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_save(canvas.canvas)
        }
        
        public func restore() {
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_restore(canvas.canvas)
        }
        
        public func measureText(text: String) -> TextMetrics {
            let _ = ensureIsContextIsCurrent()
            let data = native_measure_text(canvas.canvas, text)
            return TextMetrics(metrics: data)
        }
        public func resetTransform(){
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_reset_transform(canvas.canvas)
            canvas.doDraw()
        }
        
        public func transform(a: Float, b: Float, c: Float, d: Float, e: Float, f: Float){
            let _ = ensureIsContextIsCurrent()
            canvas.canvas = native_transform(canvas.canvas, a, b, c, d, e, f,self.canvas.getViewPtr())
            canvas.doDraw()
        }
        
        public func isPointInPath(x: Float, y: Float) -> Bool {
            return native_is_point_in_path(canvas.canvas, x, y) == 1
        }
        
        public func isPointInPath(x: Float, y: Float, fillRule: String) -> Bool {
            let ptr = (fillRule as NSString).utf8String
            return native_is_point_in_path_with_rule(canvas.canvas, x, y, ptr) == 1
        }
        
        public func isPointInPath(path: CanvasPath2D,x: Float, y: Float, fillRule: String) -> Bool {
            let ptr = (fillRule as NSString).utf8String
            return native_is_point_in_path_with_path_rule(canvas.canvas, path.path, x, y, ptr) == 1
        }
        
        public func isPointInStroke(x: Float, y: Float) -> Bool {
            return native_is_point_in_stroke(canvas.canvas, x, y) == 1
        }
        
        public func isPointInStroke(path: CanvasPath2D, x: Float, y: Float) -> Bool {
            return native_is_point_in_stroke_with_path(canvas.canvas, path.path, x, y) == 1
        }
    }
