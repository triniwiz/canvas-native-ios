//
//  WebGLRenderingContext.swift
//  CanvasNative
//
//  Created by Osei Fortune on 4/16/20.
//

import Foundation
import UIKit
import GLKit
@objcMembers
@objc(WebGLRenderingContext)
public class WebGLRenderingContext: CanvasRenderingContext {
    var canvas: Canvas
    public init(canvas: Canvas) {
        self.canvas = canvas
        super.init()
        let _ = (canvas.renderer as? GLRenderer)?.ensureIsContextIsCurrent()
        /* Enabled By default */
        self.depthMask(flag: true)
    }
    
    public init(canvas: Canvas, attrs: [String: Any]) {
        self.canvas = canvas
        super.init()
        /*
         for (key, val)  in attrs {
         switch key {
         case "alpha":
         if(val) as! Bool{
         self.enable(cap: self.BLEND)
         self.blendFunc(sfactor: self.SRC_ALPHA, dfactor: self.ONE_MINUS_SRC_ALPHA)
         }else {
         self.disable(cap: self.BLEND)
         self.blendFunc(sfactor: self.SRC_ALPHA, dfactor: self.ONE_MINUS_SRC_ALPHA)
         }
         case "antialias":
         case "depth":
         if()
         case "failIfMajorPerformanceCaveat":
         case "powerPreference":
         case "premultipliedAlpha":
         case "preserveDrawingBuffer":
         case "stencil":
         case "desynchronized":
         default:
         
         }
         }
         */
    }
    
    public func getCanvas() -> Canvas {
        return canvas
    }
    
    public var drawingBufferWidth: Int32 {
        get {
            return Int32(canvas.frame.size.width  * UIScreen.main.nativeScale)
        }
    }
    
    public var drawingBufferHeight: Int32 {
        get{
            return Int32(canvas.frame.size.height  * UIScreen.main.nativeScale)
        }
    }
    
    public func activeTexture(texture: UInt32){
        glActiveTexture(texture)
    }
    
    public func attachShader(program: UInt32, shader: UInt32){
        glAttachShader(program, shader)
    }
    
    public func bindAttribLocation(program: UInt32, index: UInt32, name: String){
        var bindName = GLchar(name)!
        glBindAttribLocation(program, index, &bindName)
    }
    
    public func bindBuffer(target: Int32, buffer: UInt32){
        glBindBuffer(GLenum(target), buffer)
    }
    
    public func bindFramebuffer(target: Int32, framebuffer: UInt32){
        if(framebuffer == 0){
            if let renderer = canvas.renderer as? GLRenderer {
                glBindFramebuffer(GLenum(target), renderer.displayFramebuffer)
                return
            }
        }
        glBindFramebuffer(GLenum(target), framebuffer)
    }
    
    public func bindRenderbuffer(target: Int32, renderbuffer: UInt32){
        glBindRenderbuffer(GLenum(target), renderbuffer)
    }
    
    public func bindTexture(target: Int32, texture: UInt32) {
        glBindTexture(GLenum(target), texture)
    }
    
    public func blendColor(red: Float32, green: Float32, blue: Float32, alpha: Float32) {
        glBlendColor(red, green, blue, alpha)
    }
    
    public func blendEquation(mode: Int32){
        glBlendEquation(GLenum(mode))
    }
    
    public func blendEquationSeparate(modeRGB: Int32, modeAlpha: Int32){
        glBlendEquationSeparate(GLenum(modeRGB), GLenum(modeAlpha))
    }
    
    public func blendFunc(sfactor: Int32, dfactor: Int32){
        glBlendFunc(GLenum(sfactor), GLenum(dfactor))
    }
    
    public func blendFuncSeparate(srcRGB: Int32, dstRGB: Int32, srcAlpha: Int32, dstAlpha: Int32){
        glBlendFuncSeparate(GLenum(srcRGB), GLenum(dstRGB), GLenum(srcAlpha), GLenum(dstAlpha))
    }
    
    var SIZE_OF_BYTE = MemoryLayout<GLubyte>.size
    var SIZE_OF_SHORT = MemoryLayout<GLshort>.size
    var SIZE_OF_FLOAT = MemoryLayout<GLfloat>.size
    var SIZE_OF_INT = MemoryLayout<GLint>.size
    var SIZE_OF_DOUBLE = MemoryLayout<Double>.size
    public func bufferData(target: Int32, size: Int32, usage: Int32){
        glBufferData(GLenum(target), GLsizeiptr(size), nil, GLenum(usage))
    }
    
    public func bufferData(target: Int32,srcData: NSNull, usage: Int32){
        var buffer = srcData
        glBufferData(GLenum(target), 0, &buffer, GLenum(usage))
    }
    
    public func bufferData(target: Int32,byteArray srcData: [UInt8], usage: Int32){
        var buffer = srcData
        let count = SIZE_OF_BYTE * buffer.count
        glBufferData(GLenum(target), count, &buffer, GLenum(usage))
    }
    
    public func bufferData(target: Int32,shortArray srcData: [UInt16], usage: Int32){
        var buffer = srcData
        let count = SIZE_OF_SHORT * buffer.count
        glBufferData(GLenum(target), count, &buffer, GLenum(usage))
    }
    
    public func bufferData(target: Int32,intArray srcData: [Int32], usage: Int32){
        var buffer = srcData
        let count = SIZE_OF_INT * buffer.count
        glBufferData(GLenum(target), count, &buffer, GLenum(usage))
    }
    
    public func bufferData(target: Int32,floatArray srcData: [Float], usage: Int32){
        var buffer = srcData
        let count = SIZE_OF_FLOAT * buffer.count
        glBufferData(GLenum(target), count, &buffer, GLenum(usage))
    }
    
    
    public func bufferSubData(target: Int32, offset: Int32,byteArray srcData: [UInt8]){
        var buffer = srcData
        let count = SIZE_OF_BYTE * buffer.count
        let os = SIZE_OF_BYTE * Int(offset)
        glBufferSubData(GLenum(target), os, count, &buffer)
    }
    
    
    public func bufferSubData(target: Int32, offset: Int32,shortArray srcData: [Int16]){
        var buffer = srcData
        let count = SIZE_OF_SHORT * buffer.count
        let os = SIZE_OF_SHORT * Int(offset)
        glBufferSubData(GLenum(target), os, count, &buffer)
    }
    public func bufferSubData(target: Int32, offset: Int32,intArray srcData: [Int32]){
        var buffer = srcData
        let count = SIZE_OF_INT * buffer.count
        let os = SIZE_OF_INT * Int(offset)
        glBufferSubData(GLenum(target), os, count, &buffer)
    }
    
    public func bufferSubData(target: Int32, offset: Int32,floatArray srcData: [Float]){
        var buffer = srcData
        let count = SIZE_OF_FLOAT * buffer.count
        let os = SIZE_OF_FLOAT * Int(offset)
        glBufferSubData(GLenum(target), os, count, &buffer)
    }
    
    
    public func checkFramebufferStatus(target: Int32) -> Int32{
        return Int32(glCheckFramebufferStatus(GLenum(target)))
    }
    
    public func clear(mask: UInt32){
        glClear(GLbitfield(mask))
    }
    
    public func clearColor(red: Float32, green: Float32, blue: Float32, alpha: Float32){
        glClearColor(red, green, blue, alpha)
    }
    
    public func clearDepth(depth: Float32){
        glClearDepthf(depth)
    }
    
    public func clearStencil(stencil: Int32){
        glClearStencil(stencil)
    }
    
    func boolConverter(value: Bool) -> UInt8 {
        if(value){
            return UInt8(GL_TRUE)
        }
        return UInt8(GL_FALSE)
    }
    
    func toBool(value: Int32) -> Bool {
        return value == GL_TRUE
    }
    
    public func colorMask(red: Bool, green: Bool, blue: Bool, alpha: Bool){
        glColorMask(boolConverter(value: red), boolConverter(value: green), boolConverter(value: blue), boolConverter(value: alpha))
    }
    
    public func commit(){
        // NOOP
    }
    
    public func compileShader(shader: UInt32){
        glCompileShader(shader)
    }
    
    public func compressedTexImage2D(target: Int32, level: Int32, internalformat: Int32, width: Int32, height: Int32, border: Int32, pixels: NSNull){
        glCompressedTexImage2D(GLenum(target), level, GLenum(internalformat), width, height, border, 0, nil)
    }
    
    
    public func compressedTexImage2D(target: Int32, level: Int32, internalformat: Int32, width: Int32, height: Int32, border: Int32,byteArray pixels: [UInt8]){
        var image = pixels
        let size = SIZE_OF_BYTE * image.count
        glCompressedTexImage2D(GLenum(target), level, GLenum(internalformat), width, height, border, GLsizei(size), &image)
    }
    
    public func compressedTexImage2D(target: Int32, level: Int32, internalformat: Int32, width: Int32, height: Int32, border: Int32,shortArray pixels: [Int16]){
        var image = pixels
        let size = SIZE_OF_SHORT * image.count
        glCompressedTexImage2D(GLenum(target), level, GLenum(internalformat), width, height, border, GLsizei(size), &image)
    }
    
    public func compressedTexImage2D(target: Int32, level: Int32, internalformat: Int32, width: Int32, height: Int32, border: Int32,intArray pixels: [Int32]){
        var image = pixels
        let size = SIZE_OF_INT * image.count
        glCompressedTexImage2D(GLenum(target), level, GLenum(internalformat), width, height, border, GLsizei(size), &image)
    }
    
    
    public func compressedTexImage2D(target: Int32, level: Int32, internalformat: Int32, width: Int32, height: Int32, border: Int32,floatArray pixels: [Float]){
        var image = pixels
        let size = SIZE_OF_FLOAT * image.count
        glCompressedTexImage2D(GLenum(target), level, GLenum(internalformat), width, height, border, GLsizei(size), &image)
    }
    
    
    public func compressedTexSubImage2D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, width: Int32, height: Int32, format: Int32,pixels: NSNull){
        glCompressedTexSubImage2D(GLenum(target), level, xoffset, yoffset, width, height, GLenum(format), 0, nil)
    }
    
    
    public func compressedTexSubImage2D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, width: Int32, height: Int32, format: Int32,byteArray pixels: [UInt8]){
        var image = pixels
        let size = SIZE_OF_BYTE * image.count
        glCompressedTexSubImage2D(GLenum(target), level, xoffset, yoffset, width, height, GLenum(format), GLsizei(size), &image)
    }
    
    
    public func compressedTexSubImage2D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, width: Int32, height: Int32, format: Int32,shortArray pixels: [Int16]){
        var image = pixels
        let size = SIZE_OF_SHORT * image.count
        glCompressedTexSubImage2D(GLenum(target), level, xoffset, yoffset, width, height, GLenum(format), GLsizei(size), &image)
    }
    
    
    public func compressedTexSubImage2D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, width: Int32, height: Int32, format: Int32,intArray pixels: [Int32]){
        var image = pixels
        let size = SIZE_OF_INT * image.count
        glCompressedTexSubImage2D(GLenum(target), level, xoffset, yoffset, width, height, GLenum(format), GLsizei(size), &image)
    }
    
    public func compressedTexSubImage2D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, width: Int32, height: Int32, format: Int32,floatArray pixels: [Float]){
        var image = pixels
        let size = SIZE_OF_FLOAT * image.count
        glCompressedTexSubImage2D(GLenum(target), level, xoffset, yoffset, width, height, GLenum(format), GLsizei(size), &image)
    }
    
    
    public func copyTexImage2D(target: Int32, level: Int32, internalformat: Int32, x: Int32, y: Int32, width: Int32, height: Int32, border: Int32) {
        glCopyTexImage2D(GLenum(target), level, GLenum(internalformat), x, y, width, height, border)
    }
    
    
    public func copyTexSubImage2D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, x: Int32, y: Int32, width: Int32, height: Int32){
        glCopyTexSubImage2D(GLenum(target), level, xoffset, yoffset, x, y, width, height)
    }
    
    public func createBuffer() -> UInt32{
        var bufferId = GLuint()
        glGenBuffers(1, &bufferId)
        return bufferId
    }
    
    public func createFramebuffer() -> UInt32 {
        var frameBufferId = GLuint()
        glGenFramebuffers(1, &frameBufferId)
        return frameBufferId
    }
    
    public func createProgram() -> UInt32 {
        return glCreateProgram()
    }
    
    public func createRenderbuffer() -> UInt32 {
        var renderBufferId = GLuint()
        glGenRenderbuffers(1, &renderBufferId)
        return renderBufferId
    }
    
    
    public func createShader(type :Int32) -> UInt32{
        return glCreateShader(GLenum(type))
    }
    
    public func createTexture() -> UInt32 {
        var textureId = GLuint()
        glGenTextures(1, &textureId)
        return textureId
    }
    
    public func cullFace(mode: Int32){
        glCullFace(GLenum(mode))
    }
    
    public func deleteBuffer(buffer: UInt32){
        var id = buffer
        glDeleteBuffers(1, &id)
    }
    
    public func deleteFramebuffer(frameBuffer: UInt32){
        var id = frameBuffer
        glDeleteFramebuffers(1, &id)
    }
    
    public func deleteProgram(program: UInt32){
        glDeleteProgram(program)
    }
    
    public func deleteRenderbuffer(renderbuffer: UInt32){
        var id = renderbuffer
        glDeleteRenderbuffers(1, &id)
    }
    public func deleteShader(shader: UInt32){
        glDeleteShader(shader)
    }
    public func deleteTexture(texture: UInt32){
        var id = texture
        glDeleteTextures(1, &id)
    }
    public func depthFunc(fn: Int32){
        glDepthFunc(GLenum(fn))
    }
    public func depthMask(flag: Bool){
        glDepthMask(boolConverter(value: flag))
    }
    public func depthRange(zNear: Float, zFar: Float){
        glDepthRangef(zNear, zFar)
    }
    public func detachShader(program: UInt32, shader: UInt32){
        glDetachShader(program, shader)
    }
    public func disable(cap: Int32){
        glDisable(GLenum(cap))
    }
    public func disableVertexAttribArray(index: Int32){
        glDisableVertexAttribArray(GLuint(index))
    }
    public func drawArrays(mode: Int32, first: Int32, count: Int32){
        glDrawArrays(GLenum(mode), first, count)
    }
    
    func BUFFER_OFFSET(n: Int) -> UnsafeRawPointer? {
        return UnsafeRawPointer(bitPattern: n)
    }
    
    func BUFFER_OFFSET_MUTABLE(n: Int) -> UnsafeMutableRawPointer? {
        return UnsafeMutableRawPointer(bitPattern: n)
    }
    
    public func drawElements(mode: Int32, count: Int32, type: Int32, offset: Int32) {
        let ptr = BUFFER_OFFSET(n: Int(offset))
        glDrawElements(GLenum(mode), count, GLenum(type), ptr)
    }
    
    public func enable(cap: Int32) {
        glEnable(GLenum(cap))
    }
    
    public func enableVertexAttribArray(index: Int32) {
        glEnableVertexAttribArray(GLuint(index))
    }
    
    public func finish(){
        glFinish()
    }
    
    public func flush(){
        glFlush()
    }
    
    
    public func framebufferRenderbuffer(target: Int32, attachment: Int32, renderbuffertarget: Int32, renderbuffer: UInt32) {
        /*if(attachment == GL_DEPTH_ATTACHMENT){
         if let renderer = canvas.renderer as? GLRenderer {
         glFramebufferRenderbuffer(GLenum(target), GLenum(GL_DEPTH_ATTACHMENT), GLenum(renderbuffertarget),renderer.displayRenderbuffer)
         
         glFramebufferRenderbuffer(GLenum(target), GLenum(GL_DEPTH_ATTACHMENT), GLenum(renderbuffertarget), renderbuffer)
         
         glFramebufferRenderbuffer(GLenum(target), GLenum(GL_STENCIL_ATTACHMENT), GLenum(renderbuffertarget), renderer.displayRenderbuffer)
         }
         }else if(attachment == GL_STENCIL_ATTACHMENT){
         if let renderer = canvas.renderer as? GLRenderer {
         glFramebufferRenderbuffer(GLenum(target), GLenum(GL_DEPTH_STENCIL_ATTACHMENT), GLenum(GL_RENDERBUFFER),renderer.displayRenderbuffer)
         
         glFramebufferRenderbuffer(GLenum(target), GLenum(GL_DEPTH_ATTACHMENT), GLenum(GL_RENDERBUFFER), renderer.displayRenderbuffer)
         
         
         glFramebufferRenderbuffer(GLenum(target), GLenum(GL_STENCIL_ATTACHMENT), GLenum(GL_RENDERBUFFER), renderbuffer)
         
         }
         }else if(attachment == GL_DEPTH_STENCIL_ATTACHMENT){
         if let renderer = canvas.renderer as? GLRenderer {
         glFramebufferRenderbuffer(GLenum(target), GLenum(GL_DEPTH_ATTACHMENT), GLenum(GL_RENDERBUFFER),renderer.displayRenderbuffer)
         
         
         glFramebufferRenderbuffer(GLenum(target), GLenum(GL_STENCIL_ATTACHMENT), GLenum(GL_RENDERBUFFER), renderer.displayRenderbuffer)
         
         glFramebufferRenderbuffer(GLenum(target), GLenum(GL_DEPTH_STENCIL_ATTACHMENT), GLenum(GL_RENDERBUFFER), renderbuffer)
         
         
         }
         }else {
         /*
         glFramebufferRenderbuffer(GLenum(target), GLenum(attachment), GLenum(renderbuffertarget), renderbuffer)
         */
         if let renderer = canvas.renderer as? GLRenderer {
         glFramebufferRenderbuffer(GLenum(target), GLenum(GL_DEPTH_STENCIL_ATTACHMENT), GLenum(GL_RENDERBUFFER), renderer.displayRenderbuffer)
         
         glFramebufferRenderbuffer(GLenum(target), GLenum(GL_DEPTH_ATTACHMENT), GLenum(GL_RENDERBUFFER), renderer.displayRenderbuffer)
         
         glFramebufferRenderbuffer(GLenum(target), GLenum(GL_STENCIL_ATTACHMENT), GLenum(GL_RENDERBUFFER), renderer.displayRenderbuffer)
         }
         }
         */
        
        glFramebufferRenderbuffer(GLenum(target), GLenum(attachment), GLenum(renderbuffertarget),renderbuffer)
    }
    
    public func framebufferTexture2D(target: Int32, attachment:Int32, textarget: Int32, texture: UInt32, level: Int32) {
        glFramebufferTexture2D(GLenum(target), GLenum(attachment), GLenum(textarget), texture, level)
    }
    
    public func frontFace(mode: Int32) {
        glFrontFace(GLenum(mode))
    }
    
    public func generateMipmap(target: Int32) {
        glGenerateMipmap(GLenum(target))
    }
    
    public func getActiveAttrib(program: UInt32,index: Int32) -> WebGLActiveInfo{
        var length = GLint()
        var size = GLint()
        var type = GLenum()
        let zero = GLchar()
        glGetProgramiv(program,GLenum(GL_ACTIVE_ATTRIBUTE_MAX_LENGTH), &length)
        var name = Array(repeatElement(zero, count: Int(length)))
        glGetActiveAttrib(program, GLuint(index), length, nil, &size, &type, &name)
        return WebGLActiveInfo(name: String(cString: &name), size: size, type: Int32(type))
    }
    
    
    public func getActiveUniform(program: UInt32,index: Int32) -> WebGLActiveInfo{
        var size = GLint()
        var type = GLenum()
        var length = GLint()
        let zero = GLchar()
        glGetProgramiv(program, GLenum(GL_ACTIVE_UNIFORMS), &length)
        var name = Array(repeatElement(zero, count: Int(length)))
        glGetActiveUniform(program, GLuint(index), length , nil, &size, &type, &name)
        return WebGLActiveInfo(name: String(cString: &name), size: size, type: Int32(type))
    }
    
    public func getAttachedShaders(program: UInt32) -> [UInt32]{
        var count = GLint()
        let zero = GLuint()
        glGetProgramiv(program,GLenum(GL_ATTACHED_SHADERS), &count)
        var shaders = Array(repeating: zero, count: Int(count))
        glGetAttachedShaders(program, count, nil, &shaders)
        return shaders
    }
    
    public func getAttribLocation(program: UInt32, name: String) -> Int32{
        let ptr = (name as NSString).cString(using: String.Encoding.utf8.rawValue)
        return glGetAttribLocation(program, ptr)
    }
    
    public func getBufferParameter(target: Int32, pname: Int32) -> Int32 {
        var params = GLint()
        glGetBufferParameteriv(GLenum(target), GLenum(pname), &params)
        return params
    }
    
    
    private var alpha: Bool = true
    private var antialias: Bool = false
    private var depth:Bool = true
    private var failIfMajorPerformanceCaveat:Bool = false
    private var powerPreference:String = "default"
    private var premultipliedAlpha: Bool = false
    private var preserveDrawingBuffer:Bool = false
    private var stencil:Bool = false
    private var desynchronized:Bool = false
    
    public func getContextAttributes() -> Any {
        // Return nil if context is lost
        if(isContextLost()){
            return NSNull()
        }
        return [
            "alpha": alpha,
            "antialias": antialias,
            "depth": depth,
            "failIfMajorPerformanceCaveat": failIfMajorPerformanceCaveat,
            "powerPreference": powerPreference,
            "premultipliedAlpha": premultipliedAlpha,
            "preserveDrawingBuffer": preserveDrawingBuffer,
            "stencil": stencil,
            "desynchronized": desynchronized
        ]
    }
    
    public func getError() -> Int32 {
        return Int32(glGetError())
    }
    
    private func getRealExtName(name: String) -> String {
        if(name.starts(with: "WEBGL_")){
            return name
        }
        return "GL_" + name
    }
    
    private func toUpperCase(name: String) -> String {
        return name.uppercased()
    }
    public func getExtension(name: String) -> Any? {
        let realName = getRealExtName(name: name)
        if let extPtr = glGetString(GLenum(GL_EXTENSIONS)) {
            let extensions = String(cString: extPtr)
            if(extensions.isEmpty){
                return NSNull()
            }
            if(name.elementsEqual("WEBGL_compressed_texture_etc1") && extensions.contains("GL_IMG_texture_compression_pvrtc")){
                return Canvas_WEBGL_compressed_texture_pvrtc()
            }else if(name.elementsEqual("WEBGL_compressed_texture_etc1")){
                return Canvas_WEBGL_compressed_texture_etc1()
            }
            if let renderer = canvas.renderer as? GLRenderer {
                if(renderer.context.api == .openGLES3){
                    switch name {
                    case "EXT_blend_minmax":
                        return Canvas_EXT_blend_minmax()
                    case "WEBGL_compressed_texture_etc":
                        return Canvas_WEBGL_compressed_texture_etc()
                    case "WEBGL_depth_texture":
                        return Canvas_WEBGL_depth_texture()
                    case "WEBGL_color_buffer_float":
                        return Canvas_WEBGL_color_buffer_float()
                    case "WEBGL_lose_context":
                        return Canvas_WEBGL_lose_context(canvas: self.canvas)
                    case "OES_texture_half_float":
                        return Canvas_OES_texture_half_float()
                    case "OES_texture_half_float_linear":
                        return Canvas_OES_texture_half_float_linear()
                    case "OES_texture_float":
                        //EXT_color_buffer_half_float
                        return Canvas_OES_texture_float()
                    case "OES_element_index_uint":
                        return Canvas_OES_element_index_uint()
                    case "OES_fbo_render_mipmap":
                        return Canvas_OES_fbo_render_mipmap()
                    case "OES_standard_derivatives":
                        return Canvas_OES_standard_derivatives()
                    case "OES_texture_float_linear":
                        return Canvas_OES_texture_float_linear()
                    case "OES_depth_texture":
                        return Canvas_WEBGL_depth_texture()
                    case "WEBGL_draw_buffers":
                        return Canvas_WEBGL_draw_buffers()
                    default: break
                    }
                }
            }
            if(name.elementsEqual("ANGLE_instanced_arrays")){
                return Canvas_ANGLE_instanced_arrays(context: self)
            }
            if(extensions.contains(realName)){
                switch (realName){
                case getRealExtName(name: "EXT_blend_minmax"):
                    return Canvas_EXT_blend_minmax()
                case getRealExtName(name: "EXT_color_buffer_float"):
                    return Canvas_EXT_color_buffer_float()
                case getRealExtName(name: "EXT_color_buffer_half_float"):
                    return Canvas_EXT_color_buffer_half_float()
                case getRealExtName(name: "EXT_sRGB"):
                    return Canvas_EXT_sRGB()
                case getRealExtName(name: "EXT_shader_texture_lod"):
                    return Canvas_EXT_shader_texture_lod()
                case getRealExtName(name: "EXT_texture_filter_anisotropic"):
                    return Canvas_EXT_texture_filter_anisotropic()
                case getRealExtName(name: "OES_element_index_uint"):
                    return Canvas_OES_element_index_uint()
                case getRealExtName(name: "EXT_texture_filter_anisotropic"):
                    return Canvas_EXT_texture_filter_anisotropic()
                case getRealExtName(name: "OES_fbo_render_mipmap"):
                    return Canvas_OES_fbo_render_mipmap()
                case getRealExtName(name: "OES_standard_derivatives"):
                    return Canvas_OES_standard_derivatives()
                case getRealExtName(name: "OES_texture_float_linear"):
                    return Canvas_OES_texture_float_linear()
                case getRealExtName(name: "OES_texture_half_float"):
                    return Canvas_OES_texture_half_float()
                case getRealExtName(name: "OES_texture_half_float_linear"):
                    return Canvas_OES_texture_half_float_linear()
                case getRealExtName(name: "OES_depth_texture"):
                    return Canvas_WEBGL_depth_texture()
                    // N/A
                    //EXT_float_blend
                    //EXT_frag_depth
                    //EXT_texture_compression_bptc
                    //EXT_texture_compression_rgtc
                    //OVR_multiview2
                    //WEBGL_compressed_texture_astc
                    //WEBGL_compressed_texture_atc
                    //WEBGL_compressed_texture_s3tc
                    //WEBGL_compressed_texture_s3tc_srgb
                    //WEBGL_debug_renderer_info
                //EBGL_debug_shaders
                default:
                    return NSNull()
                }
            }
            return NSNull()
        }
        return NSNull()
    }
    
    public func getFramebufferAttachmentParameter(target: Int32, attachment: Int32, pname: Int32) -> FramebufferAttachmentParameter {
        var params = GLint()
        let result = FramebufferAttachmentParameter(isTexture: false, isRenderbuffer: false, value: 0)
        if(attachment == FRAMEBUFFER_ATTACHMENT_OBJECT_NAME){
            glGetFramebufferAttachmentParameteriv(GLenum(target), GLenum(attachment), GLenum(pname), &params)
            var name = GLint()
            glGetFramebufferAttachmentParameteriv(GLenum(target),GLenum(attachment), GLenum(GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE), &name)
            switch name {
            case GL_RENDERBUFFER:
                result._isRenderbuffer = true
                result._value = params
            case GL_TEXTURE:
                result._isTexture = true
                result._value = params
            default:
                result._value = params
            }
        }else {
            glGetFramebufferAttachmentParameteriv(GLenum(target), GLenum(attachment), GLenum(pname), &params)
            result._value = params
        }
        return result
    }
    
    
    func fromGLboolean(value: UInt8) -> Bool{
        return value == GL_TRUE
    }
    
    func fromGLbooleanArray(value: [UInt8]) -> [Bool]{
        return value.map { val -> Bool in
            return val == GL_TRUE
        }
    }
    func fromGLint(value: [Int32]) -> [Bool]{
        return value.map { val -> Bool in
            return val == GL_TRUE
        }
    }
    public func getParameter(pname: Int32) -> Any?{
        switch pname {
        case ACTIVE_TEXTURE, ALPHA_BITS, ARRAY_BUFFER_BINDING, BLEND_DST_ALPHA, BLEND_DST_RGB, BLEND_EQUATION, BLEND_EQUATION_ALPHA, BLEND_EQUATION_RGB, BLEND_SRC_ALPHA, BLEND_SRC_RGB, BLUE_BITS, CULL_FACE_MODE, CURRENT_PROGRAM, DEPTH_BITS, DEPTH_FUNC, ELEMENT_ARRAY_BUFFER_BINDING, FRAMEBUFFER_BINDING, FRONT_FACE, GENERATE_MIPMAP_HINT, GREEN_BITS, IMPLEMENTATION_COLOR_READ_FORMAT, IMPLEMENTATION_COLOR_READ_TYPE, MAX_COMBINED_TEXTURE_IMAGE_UNITS, MAX_CUBE_MAP_TEXTURE_SIZE, MAX_FRAGMENT_UNIFORM_VECTORS, MAX_RENDERBUFFER_SIZE, MAX_TEXTURE_IMAGE_UNITS, MAX_TEXTURE_SIZE,MAX_VARYING_VECTORS, MAX_VERTEX_ATTRIBS, MAX_VERTEX_TEXTURE_IMAGE_UNITS, MAX_VERTEX_UNIFORM_VECTORS, PACK_ALIGNMENT, RED_BITS, RENDERBUFFER_BINDING, SAMPLE_BUFFERS, SAMPLES, STENCIL_BACK_FAIL, STENCIL_BACK_FUNC, STENCIL_BACK_PASS_DEPTH_FAIL, STENCIL_BACK_PASS_DEPTH_PASS, STENCIL_BACK_REF, STENCIL_BACK_VALUE_MASK, STENCIL_BACK_WRITEMASK, STENCIL_BITS,STENCIL_CLEAR_VALUE,STENCIL_FAIL, STENCIL_FUNC,STENCIL_PASS_DEPTH_FAIL,STENCIL_PASS_DEPTH_PASS,STENCIL_REF,STENCIL_VALUE_MASK, STENCIL_WRITEMASK, SUBPIXEL_BITS, TEXTURE_BINDING_2D, TEXTURE_BINDING_CUBE_MAP, UNPACK_ALIGNMENT:
            var param = GLint()
            glGetIntegerv(GLenum(pname), &param)
            if((pname == TEXTURE_BINDING_2D || pname == TEXTURE_BINDING_CUBE_MAP || pname == RENDERBUFFER_BINDING || pname == FRAMEBUFFER_BINDING) && param == 0){
                return nil
            }
            return param
        case ALIASED_LINE_WIDTH_RANGE, ALIASED_POINT_SIZE_RANGE, DEPTH_RANGE:
            var param = Array(repeating: GLfloat(), count: 2)
            glGetFloatv(GLenum(pname), &param)
            return param
        case BLEND_COLOR, COLOR_CLEAR_VALUE:
            var param = Array(repeating: GLfloat(), count: 4)
            glGetFloatv(GLenum(pname), &param)
            return param
        case BLEND, CULL_FACE, DEPTH_TEST, DEPTH_WRITEMASK, DITHER, POLYGON_OFFSET_FILL, SAMPLE_COVERAGE_INVERT, SCISSOR_TEST, STENCIL_TEST:
            var param = GLboolean()
            glGetBooleanv(GLenum(pname), &param)
            return  fromGLboolean(value: param)
        case UNPACK_PREMULTIPLY_ALPHA_WEBGL:
            return premultiplyAlphaWebGL
        case UNPACK_FLIP_Y_WEBGL:
            return flipYWebGL
        case UNPACK_COLORSPACE_CONVERSION_WEBGL:
            var cs = colorSpaceConversionWebGL
            if(cs == -1){
                cs = BROWSER_DEFAULT_WEBGL
            }
            return cs
        case COLOR_WRITEMASK:
            var param = Array(repeating: GLboolean(), count: 4)
            glGetBooleanv(GLenum(pname), &param)
            return fromGLbooleanArray(value: param)
        case COMPRESSED_TEXTURE_FORMATS:
            var count = GLint()
            glGetIntegerv(GLenum(GL_NUM_COMPRESSED_TEXTURE_FORMATS), &count)
            var params = Array(repeating: GLint(), count: Int(count))
            glGetIntegerv(GLenum(GL_COMPRESSED_TEXTURE_FORMATS), &params)
            return params
        case DEPTH_CLEAR_VALUE, LINE_WIDTH, POLYGON_OFFSET_FACTOR, POLYGON_OFFSET_UNITS, SAMPLE_COVERAGE_VALUE:
            var param = GLfloat()
            glGetFloatv(GLenum(pname), &param)
            return param
        case MAX_VIEWPORT_DIMS:
            var params = Array(repeating: GLint(), count: 2)
            glGetIntegerv(GLenum(pname), &params)
            return params
        case SCISSOR_BOX, VIEWPORT:
            var params = Array(repeating: GLint(), count: 4)
            glGetIntegerv(GLenum(pname), &params)
            return params
        case RENDERER, SHADING_LANGUAGE_VERSION, VENDOR, VERSION:
            let params = glGetString(GLenum(pname))
            if(params == nil){
                return nil
            }
            return String(cString: params!)
        default:
            return nil
        }
    }
    
    public func getProgramInfoLog(program: UInt32) -> String {
        var length = GLint()
        glGetProgramiv(program, GLenum(GL_INFO_LOG_LENGTH), &length)
        // let zero = GLchar()
        // var info = Array(repeatElement(zero, count: Int(length)))
        let ptr = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(length))
        glGetProgramInfoLog(program, length, nil, ptr)
        let result = String(cString: ptr)
        ptr.deallocate()
        return result
    }
    
    
    public func getProgramParameter(program: UInt32, pname: Int32) -> Any {
        var param = GLint()
        glGetProgramiv(program, GLenum(pname), &param)
        switch pname {
        case DELETE_STATUS:
            if(param == GL_TRUE){
                return true
            }
            return false
        case LINK_STATUS:
            if(param == GL_TRUE){
                return true
            }
            return false
        case VALIDATE_STATUS:
            if(param == GL_TRUE){
                return true
            }
            return false
        default:
            return param
        }
    }
    
    
    public func getRenderbufferParameter(target: Int32, pname: Int32) -> Int32{
        var params = GLint()
        glGetRenderbufferParameteriv(GLenum(target), GLenum(pname), &params)
        return params
    }
    
    public func getShaderInfoLog(shader: UInt32) -> String  {
        var length = GLint()
        glGetShaderiv(shader, GLenum(GL_INFO_LOG_LENGTH), &length)
        let ptr = UnsafeMutablePointer<GLchar>.allocate(capacity: Int(length))
        // let zero = GLchar()
        // var info: [GLchar] = Array(repeatElement(zero, count: Int(length)))
        glGetShaderInfoLog(shader, length, nil, ptr)
        let result = String(cString: ptr)
        ptr.deallocate()
        return result
    }
    
    public func getShaderParameter(shader: UInt32, pname: Int32) -> Any {
        var params = GLint()
        glGetShaderiv(shader, GLenum(pname), &params)
        switch pname {
        case DELETE_STATUS:
            if(params == GL_TRUE){
                return true
            }
            return false
        case COMPILE_STATUS:
            if(params == GL_TRUE){
                return true
            }
            return false
        default:
            return params
        }
    }
    
    public func getShaderPrecisionFormat(shaderType: UInt32, precisionType: Int32) -> WebGLShaderPrecisionFormat{
        var range = Array(repeating: GLint(), count: 2)
        var precision = GLint()
        glGetShaderPrecisionFormat(shaderType, GLenum(precisionType), &range, &precision)
        return WebGLShaderPrecisionFormat(rangeMin: range[0], rangeMax: range[1], precision: precision)
    }
    
    public func getShaderSource(shader: UInt32) -> String{
        var length = GLint()
        let zero = GLchar()
        glGetShaderiv(shader, GLenum(GL_SHADER_SOURCE_LENGTH), &length)
        var source = Array(repeating: zero, count: Int(length))
        glGetShaderSource(shader, length, nil, &source)
        return String(cString: source)
    }
    
    public func getSupportedExtensions() -> [String]{
        let extensions = String(cString: glGetString(GLenum(GL_EXTENSIONS)))
        var list = extensions.components(separatedBy: .whitespaces)
        if let last = list.last {
            if(last.isEmpty){
                let _ = list.popLast()
            }
        }
        
        list.append("EXT_blend_minmax")
        list.append("EXT_color_buffer_float")
        list.append("EXT_color_buffer_half_float")
        list.append("EXT_sRGB")
        list.append("EXT_shader_texture_lod")
        list.append("EXT_texture_filter_anisotropic")
        list.append("OES_element_index_uint")
        list.append("OES_fbo_render_mipmap")
        list.append("OES_standard_derivatives")
        list.append("OES_texture_float")
        list.append("OES_texture_float_linear")
        list.append("OES_texture_half_float")
        list.append("OES_texture_half_float_linear")
        list.append("WEBGL_color_buffer_float")
        list.append("WEBGL_compressed_texture_etc")
        list.append("WEBGL_compressed_texture_etc1")
        list.append("WEBGL_compressed_texture_pvrtc")
        list.append("WEBGL_depth_texture")
        list.append("WEBGL_lose_context")
        
        return list
    }
    
    
    public func getTexParameter(target: Int32, pname: Int32) -> Int32{
        var params = GLint()
        glGetTexParameteriv(GLenum(target), GLenum(pname), &params)
        return params
    }
    
    func getFloatSlice(_ count: Int) -> [Float]{
        return []
    }
    
    func getIntSlice(_ count: Int) -> [Int32] {
        return []
    }
    
    public func getUniform(program: UInt32, location: Int32) -> Any{
        var type = GLuint()
        glGetActiveUniform(program, GLuint(location), 0, nil, nil, &type, nil)
        switch Int32(type) {
        case GL_FLOAT:
            var single = getFloatSlice(1)
            glGetUniformfv(program, location, &single)
            return single[0]
        case GL_FLOAT_VEC2:
            var vec2 = getFloatSlice(2)
            glGetUniformfv(program, location, &vec2)
            return vec2
        case GL_FLOAT_VEC3:
            var vec3 = getFloatSlice(3)
            glGetUniformfv(program, location, &vec3)
            return vec3
        case GL_FLOAT_VEC4:
            var vec4 = getFloatSlice(4)
            glGetUniformfv(program, location, &vec4)
            return vec4
        case GL_INT, GL_SAMPLER_2D, GL_SAMPLER_CUBE:
            var singleInt = getIntSlice(1)
            glGetUniformiv(program, location, &singleInt)
            return singleInt[0]
        case GL_INT_VEC2:
            var intVec2 = getIntSlice(2)
            glGetUniformiv(program, location, &intVec2)
            return intVec2
        case GL_INT_VEC3:
            var intVec3 = getIntSlice(3)
            glGetUniformiv(program, location, &intVec3)
            return intVec3
        case GL_INT_VEC4:
            var intVec4 = getIntSlice(4)
            glGetUniformiv(program, location, &intVec4)
            return intVec4
        case GL_BOOL:
            var singleBool = getIntSlice(1)
            glGetUniformiv(program, location, &singleBool)
            return singleBool[0] == GL_TRUE
        case GL_BOOL_VEC2:
            var boolVec2 = getIntSlice(2)
            var boolVec2Result: [Bool] = []
            glGetUniformiv(program, location, &boolVec2)
            boolVec2Result.append(boolVec2[0] == GL_TRUE)
            boolVec2Result.append(boolVec2[1] == GL_TRUE)
            return boolVec2Result
        case GL_BOOL_VEC3:
            var boolVec3 = getIntSlice(3);
            var boolVec3Result: [Bool] = []
            glGetUniformiv(program, location, &boolVec3)
            boolVec3Result.append(boolVec3[0] == GL_TRUE)
            boolVec3Result.append(boolVec3[1] == GL_TRUE)
            boolVec3Result.append(boolVec3[2] == GL_TRUE)
            return boolVec3Result
        case GL_BOOL_VEC4:
            var boolVec4 = getIntSlice(4)
            var boolVec4Result: [Bool] = []
            glGetUniformiv(program, location, &boolVec4)
            boolVec4Result.append(boolVec4[0] == GL_TRUE)
            boolVec4Result.append(boolVec4[1] == GL_TRUE)
            boolVec4Result.append(boolVec4[2] == GL_TRUE)
            boolVec4Result.append(boolVec4[3] == GL_TRUE)
            return boolVec4Result
        case GL_FLOAT_MAT2:
            var mat2 = getFloatSlice(2)
            glGetUniformfv(program, location, &mat2)
            return mat2
        case GL_FLOAT_MAT3:
            var mat3 = getFloatSlice(3)
            glGetUniformfv(program, location, &mat3)
            return mat3
        case GL_FLOAT_MAT4:
            var mat4 = getFloatSlice(4)
            glGetUniformfv(program, location, &mat4)
            return mat4
        default:
            return NSNull()
        }
        
    }
    
    public func getUniformLocation(program: UInt32, name: String) -> Int32 {
        let namePtr = (name as NSString).cString(using: String.Encoding.utf8.rawValue)
        return glGetUniformLocation(program, namePtr)
    }
    
    
    public func getVertexAttrib(index: UInt32, pname: Int32) -> Any {
        if(pname == CURRENT_VERTEX_ATTRIB){
            let zero = GLfloat()
            var params = Array(repeating: zero, count: 4)
            glGetVertexAttribfv(index, GLenum(pname), &params)
            return params
        }
        var params = GLint()
        glGetVertexAttribiv(index, GLenum(pname), &params)
        switch pname {
        case VERTEX_ATTRIB_ARRAY_ENABLED:
            if(params == GL_TRUE){
                return true
            }
            return false
        case VERTEX_ATTRIB_ARRAY_NORMALIZED:
            if(params == GL_TRUE){
                return true
            }
            return false
        default:
            return params
        }
    }
    
    
    public func getVertexAttribOffset(index: Int32, pname: Int32) -> Int {
        let ptr = UnsafeMutablePointer<GLintptr>.allocate(capacity: 1)
        // var pointer = UnsafeMutableRawPointer(&ptr)
        var pointer: UnsafeMutableRawPointer? = ptr.deinitialize(count: 1)
        glGetVertexAttribPointerv(GLuint(index), GLenum(pname), &pointer)
        return ptr.move()
    }
    
    
    public func hint(target: Int32, mode: Int32){
        glHint(GLenum(target), GLenum(mode))
    }
    
    
    public func isBuffer(buffer: UInt32) -> Bool{
        return glIsBuffer(buffer) == GL_TRUE
    }
    
    public func isContextLost() -> Bool {
        if let renderer = canvas.renderer as? GLRenderer {
            return EAGLContext.current() != renderer.glkView.context
        }
        return false
    }
    
    
    public func isEnabled(cap: Int32) -> Bool {
        return glIsEnabled(GLenum(cap)) == GL_TRUE
    }
    
    
    public func isFramebuffer(framebuffer: UInt32) -> Bool {
        return glIsFramebuffer(framebuffer) == GL_TRUE
    }
    
    
    public func isProgram(program: UInt32) -> Bool {
        return glIsProgram(program) == GL_TRUE
    }
    
    public func isRenderbuffer(renderbuffer: UInt32) -> Bool {
        return glIsRenderbuffer(renderbuffer) == GL_TRUE
    }
    
    public func isShader(shader: UInt32) ->Bool {
        return glIsShader(shader) == GL_TRUE
    }
    
    public func isTexture(texture: UInt32) -> Bool {
        return glIsTexture(texture)  == GL_TRUE
    }
    
    public func lineWidth(width: Float){
        glLineWidth(width)
    }
    
    public func linkProgram(program: UInt32){
        glLinkProgram(program)
    }
    
    
    
    private func anyToInt(_ value: Any?, _ defaultValue: Int32) -> Int32 {
        if (value != nil) {
            if let intVal = value as? Int32 {
                return intVal
            }
            return defaultValue
        }
        return defaultValue
    }
    
    private func anyToBoolean(_ value: Any?, _ defaultValue: Bool) -> Bool {
        if (value != nil) {
            if let boolVal = value as? Bool {
                return boolVal
            }
            return defaultValue
        }
        return defaultValue
    }
    
    private func anyToColorSpace(_ value: Any?, _ defaultValue: Int32) -> Int32 {
        if (value != nil) {
            if let intVal = value as? Int32 {
                if(intVal == BROWSER_DEFAULT_WEBGL || intVal == GL_NONE){
                    return intVal
                }
                return BROWSER_DEFAULT_WEBGL
            }
            return defaultValue
        }
        return defaultValue
    }
    
    var flipYWebGL: Bool = false
    var premultiplyAlphaWebGL: Bool = false
    var colorSpaceConversionWebGL: Int32 = -1
    public func pixelStorei(pname: Int32, param: Int32) {
        switch pname {
        case UNPACK_ALIGNMENT, PACK_ALIGNMENT:
            glPixelStorei(GLenum(pname), anyToInt(param, 4))
            break;
        case UNPACK_FLIP_Y_WEBGL:
            flipYWebGL = anyToBoolean(param, false)
        case UNPACK_PREMULTIPLY_ALPHA_WEBGL:
            premultiplyAlphaWebGL = anyToBoolean(param, false)
        case UNPACK_COLORSPACE_CONVERSION_WEBGL:
            colorSpaceConversionWebGL = anyToColorSpace(param, BROWSER_DEFAULT_WEBGL)
        default:
            break;
        }
    }
    
    
    public func polygonOffset(factor: Float, units: Float){
        glPolygonOffset(factor, units)
    }
    
    public func readPixels(x: Int32, y: Int32, width: Int32, height: Int32, format: Int32, type: Int32,byteArray pixels: [UInt8]) {
        var array = pixels
        glReadPixels(x, y, width, height, GLenum(format), GLenum(type), &array)
    }
    
    public func readPixels(x: Int32, y: Int32, width: Int32, height: Int32, format: Int32, type: Int32,shortArray pixels: [UInt16]) {
        var array = pixels
        glReadPixels(x, y, width, height, GLenum(format), GLenum(type), &array)
    }
    
    
    public func readPixels(x: Int32, y: Int32, width: Int32, height: Int32, format: Int32, type: Int32,floatArray pixels: [Float]) {
        var array = pixels
        glReadPixels(x, y, width, height, GLenum(format), GLenum(type), &array)
    }
    
    
    public func renderbufferStorage(target: Int32, internalFormat: Int32, width: Int32, height: Int32) {
        glRenderbufferStorage(GLenum(target), GLenum(internalFormat), width, height)
    }
    
    
    public func sampleCoverage(value:Float, invert: Bool){
        glSampleCoverage(value, boolConverter(value: invert))
    }
    
    
    public func scissor(x: Int32, y: Int32, width: Int32, height: Int32){
        glScissor(x, y, width, height)
    }
    
    public func shaderSource(shader: UInt32, source: String) {
        var ptr = (source as NSString).cString(using: String.Encoding.utf8.rawValue)
        glShaderSource(shader, 1, &ptr, nil)
    }
    
    public func stencilFunc(fn:Int32, ref: Int32, mask: UInt32) {
        glStencilFunc(GLenum(fn), ref, mask)
    }
    
    
    public func stencilFuncSeparate(face: Int32, fn: Int32, ref:Int32, mask: UInt32){
        glStencilFuncSeparate(GLenum(face), GLenum(fn), ref, mask)
    }
    
    public func stencilMask(mask: UInt32){
        glStencilMask(mask)
    }
    
    public func stencilMaskSeparate(face: Int32, mask: UInt32) {
        glStencilMaskSeparate(GLenum(face), mask)
    }
    
    public func stencilOp(fail: Int32, zfail: Int32, zpass: Int32) {
        glStencilOp(GLenum(fail), GLenum(zfail), GLenum(zpass))
    }
    
    public func stencilOpSeparate(face: Int32, fail: Int32, zfail: Int32, zpass: Int32) {
        glStencilOpSeparate(GLenum(face), GLenum(fail), GLenum(zfail), GLenum(zpass))
    }
    
    
    public func texImage2D(target: Int32, level: Int32, internalformat: Int32, width: Int32, height: Int32, border: Int32, format: Int32, type: Int32, pixels: NSNull) {
        glTexImage2D(GLenum(target), level, internalformat, width, height, border, GLenum(format), GLenum(type), nil)
    }
    
    
    public func texImage2D(target: Int32, level: Int32, internalformat: Int32, width: Int32, height: Int32, border: Int32, format: Int32, type: Int32,byteArray pixels: [UInt8]) {
        var data = pixels
        if(flipYWebGL){
            native_image_asset_flip_x_in_place_owned(UInt32(width), UInt32(height), &data, UInt(pixels.count))
        }
        glTexImage2D(GLenum(target), level, internalformat, width, height, border, GLenum(format), GLenum(type), &data)
    }
    
    public func texImage2D(target: Int32, level: Int32, internalformat: Int32, width: Int32, height: Int32, border: Int32, format: Int32, type: Int32,shortArray pixels: [Int16]) {
        var data = pixels
        glTexImage2D(GLenum(target), level, internalformat, width, height, border, GLenum(format), GLenum(type), &data)
    }
    
    public func texImage2D(target: Int32, level: Int32, internalformat: Int32, width: Int32, height: Int32, border: Int32, format: Int32, type: Int32,intArray pixels: [Int32]) {
        var data = pixels
        glTexImage2D(GLenum(target), level, internalformat, width, height, border, GLenum(format), GLenum(type), &data)
    }
    
    public func texImage2D(target: Int32, level: Int32, internalformat: Int32, width: Int32, height: Int32, border: Int32, format: Int32, type: Int32,floatArray pixels: [Float]) {
        var data = pixels
        glTexImage2D(GLenum(target), level, internalformat, width, height, border, GLenum(format), GLenum(type), &data)
    }
    
    public func texImage2D(target: Int32, level: Int32, internalformat: Int32, format: Int32, type: Int32, pixels: UIImage) {
        var cgImage: CGImage?
        
        if let image = pixels.cgImage {
            cgImage = image
        } else if let image = pixels.ciImage {
            var ctx: CIContext?
            if let renderer = canvas.renderer as? GLRenderer {
                ctx = CIContext(eaglContext: renderer.context)
            }
            if let context = ctx {
                cgImage = context.createCGImage(image, from: image.extent)
            }
        }
        if let image = cgImage {
            let width = Int(pixels.size.width)
            let height = Int(pixels.size.height)
            let buffer = calloc(width * height, 4)
            let colorSpace = CGColorSpaceCreateDeviceRGB()
            let imageCtx = CGContext(data: buffer, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue)
            //imageCtx!.clear(CGRect(x: 0, y: 0, width: width, height: height))
            //imageCtx!.translateBy(x: 0, y: CGFloat(height - height))
            imageCtx!.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))
            
            
            if(flipYWebGL){
                native_image_asset_flip_x_in_place_owned(UInt32(width), UInt32(height), buffer?.assumingMemoryBound(to: UInt8.self), UInt(width * height * 4))
            }
            
            glTexImage2D(GLenum(target), level, internalformat, GLsizei(width), GLsizei(height), 0, GLenum(format), GLenum(type), buffer)
            
            buffer?.deallocate()
            
        }
        
    }
    
    public func texImage2D(target: Int32, level: Int32, internalformat: Int32, format: Int32, type: Int32, asset: ImageAsset) {
        if(flipYWebGL){
            native_image_asset_flip_x_in_place_owned(UInt32(asset.width), UInt32(asset.height), asset.getRawBytes(), UInt(asset.length))
        }
        glTexImage2D(GLenum(target), level, internalformat, GLsizei(asset.width), GLsizei(asset.height), 0, GLenum(format), GLenum(type), asset.getRawBytes())
    }
    
    public func texImage2D(target: Int32, level: Int32, internalformat: Int32, format: Int32, type: Int32,none pixels: NSNull) {
        glTexImage2D(GLenum(target), level, internalformat, 0, 0, 0, GLenum(format), GLenum(type), nil)
    }
    
    
    public func texParameterf(target: Int32, pname: Int32, param: Float) {
        glTexParameterf(GLenum(target), GLenum(pname), param)
    }
    
    public func texParameteri(target: Int32, pname: Int32, param: Int32) {
        glTexParameteri(GLenum(target), GLenum(pname), param)
    }
    
    
    public func texSubImage2D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, width: Int32, height: Int32, format: Int32, type:Int32,pixels: NSNull) {
        glTexSubImage2D(GLenum(target), level, xoffset, yoffset, width, height, GLenum(format), GLenum(type), nil)
    }
    
    public func texSubImage2D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, width: Int32, height: Int32, format: Int32, type:Int32,byteArray pixels: [UInt8]) {
        var data = pixels
        if(flipYWebGL){
            native_image_asset_flip_y_in_place_owned(UInt32(width), UInt32(height), &data, UInt(data.count))
        }
        glTexSubImage2D(GLenum(target), level, xoffset, yoffset, width, height, GLenum(format), GLenum(type), &data)
    }
    
    public func texSubImage2D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, width: Int32, height: Int32, format: Int32, type:Int32,shortArray pixels: [Int16]) {
        var data = pixels
        glTexSubImage2D(GLenum(target), level, xoffset, yoffset, width, height, GLenum(format), GLenum(type), &data)
    }
    
    public func texSubImage2D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, width: Int32, height: Int32, format: Int32, type:Int32,floatArray pixels: [Float]) {
        var data = pixels
        glTexSubImage2D(GLenum(target), level, xoffset, yoffset, width, height, GLenum(format), GLenum(type), &data)
    }
    
    public func texSubImage2D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, format: Int32, type:Int32, pixels: UIImage) {
        var cgImage: CGImage?
        if let image = pixels.cgImage {
            cgImage = image
        }else if let image = pixels.ciImage {
            var context: CIContext?
            if let renderer = canvas.renderer as? GLRenderer {
                context = CIContext(eaglContext: renderer.context)
            }
            if let ctx = context {
                cgImage = ctx.createCGImage(image, from: image.extent)
            }
        }
        
        if let image = cgImage {
            let width = Int(pixels.size.width)
            let height = Int(pixels.size.height)
            let buffer = calloc(width * height, 4)
            let imageCtx = CGContext(data: buffer, width: width, height: height, bitsPerComponent: 8, bytesPerRow: width * 4, space: image.colorSpace!, bitmapInfo: image.alphaInfo.rawValue)
            imageCtx!.draw(image, in: CGRect(x: 0, y: 0, width: width, height: height))
            
            
            if(flipYWebGL){
                native_image_asset_flip_y_in_place_owned(UInt32(width), UInt32(height), buffer?.assumingMemoryBound(to: UInt8.self), UInt(width * height * 4))
            }
            
            glTexSubImage2D(GLenum(target), level, xoffset, yoffset, GLsizei(pixels.size.width), GLsizei(pixels.size.height), GLenum(format), GLenum(type), buffer)
            buffer?.deallocate()
        }
    }
    
    
    public func texSubImage2D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, format: Int32, type:Int32, asset: ImageAsset) {
        let width = asset.width
        let height = asset.height
        if(flipYWebGL){
            native_image_asset_flip_y_in_place_owned(UInt32(width), UInt32(height), asset.getRawBytes(), UInt((width * height * 4)))
        }
        
        glTexSubImage2D(GLenum(target), level, xoffset, yoffset, GLsizei(asset.width), GLsizei(asset.height), GLenum(format), GLenum(type), asset.getRawBytes())
    }
    
    
    public func texSubImage2D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, format: Int32, type:Int32,none pixels: NSNull) {
        glTexSubImage2D(GLenum(target), level, xoffset, yoffset, 0, 0, GLenum(format), GLenum(type), nil)
    }
    
    
    public func uniform1f(location: Int32, v0: Float) {
        glUniform1f(location, v0)
    }
    
    public func uniform1fv(location: Int32, value: [Float]) {
        var v0 = value
        glUniform1fv(location, 1, &v0)
    }
    
    
    public func uniform1i(location: Int32, v0: Int32) {
        glUniform1i(location, v0)
    }
    
    public func uniform1iv(location: Int32, value: [Int32]) {
        var v0 = value
        glUniform1iv(location, 1, &v0)
    }
    
    
    public func uniform2f(location: Int32, v0: Float, v1: Float) {
        glUniform2f(location, v0, v1)
    }
    
    public func uniform2fv(location: Int32, value: [Float]) {
        var v0 = value
        glUniform1fv(location, 1, &v0)
    }
    
    
    public func uniform2i(location: Int32, v0: Int32, v1: Int32) {
        glUniform2i(location, v0, v1)
    }
    
    public func uniform2iv(location: Int32, value: [Int32]) {
        var v0 = value
        glUniform2iv(location, 1, &v0)
    }
    
    
    public func uniform3f(location: Int32, v0: Float, v1: Float, v2: Float) {
        glUniform3f(location, v0, v1, v2)
    }
    
    public func uniform3fv(location: Int32, value: [Float]) {
        var v0 = value
        glUniform3fv(location, 1, &v0)
    }
    
    
    public func uniform3i(location: Int32, v0: Int32, v1: Int32, v2: Int32) {
        glUniform3i(location, v0, v1, v2)
    }
    
    public func uniform3iv(location: Int32, value: [Int32]) {
        var v0 = value
        glUniform3iv(location, 1, &v0)
    }
    
    public func uniform4f(location: Int32, v0: Float, v1: Float, v2: Float, v3: Float) {
        glUniform4f(location, v0, v1, v2, v3)
    }
    
    public func uniform4fv(location: Int32, value: [Float]) {
        var v0 = value
        glUniform4fv(location, 1, &v0)
    }
    
    public func uniform4i(location: Int32, v0: Int32, v1: Int32, v2: Int32, v3: Int32) {
        glUniform4i(location, v0, v1, v2, v3)
    }
    
    public func uniform4iv(location: Int32, value: [Int32]) {
        var v0 = value
        glUniform4iv(location, 1, &v0)
    }
    
    public func uniformMatrix2fv(location: Int32, transpose: Bool, value: [Float]) {
        var array = value
        glUniformMatrix2fv(location, 1, boolConverter(value: transpose), &array)
    }
    
    public func uniformMatrix3fv(location: Int32, transpose: Bool, value: [Float]) {
        var array = value
        glUniformMatrix3fv(location, 1, boolConverter(value: transpose), &array)
    }
    
    public func uniformMatrix4fv(location: Int32, transpose: Bool, value: [Float]) {
        var array = value
        glUniformMatrix4fv(location, 1, boolConverter(value: transpose), &array)
    }
    
    public func useProgram(program: UInt32){
        glUseProgram(program)
    }
    
    public func validateProgram(program: UInt32){
        glValidateProgram(program)
    }
    
    public func vertexAttrib1f(index: Int32, v0: Float) {
        glVertexAttrib1f(GLuint(index), v0)
    }
    
    public func vertexAttrib2f(index: Int32, v0: Float, v1: Float) {
        glVertexAttrib2f(GLuint(index), v0, v1)
    }
    
    public func vertexAttrib3f(index: Int32, v0: Float, v1: Float, v2: Float) {
        glVertexAttrib3f(GLuint(index), v0, v1, v2)
    }
    
    public func vertexAttrib4f(index: Int32, v0: Float, v1: Float, v2: Float, v3: Float) {
        glVertexAttrib4f(GLuint(index), v0, v1, v2, v3)
    }
    
    public func vertexAttrib1fv(index: Int32, value: [Float]) {
        var v0 = value
        glVertexAttrib1fv(GLuint(index),&v0)
    }
    
    public func vertexAttrib2fv(index: Int32, value: [Float]) {
        var v0 = value
        glVertexAttrib2fv(GLuint(index),&v0)
    }
    
    public func vertexAttrib3fv(index: Int32, value: [Float]) {
        var v0 = value
        glVertexAttrib3fv(GLuint(index),&v0)
    }
    
    public func vertexAttrib4fv(index: Int32, value: [Float]) {
        var v0 = value
        glVertexAttrib4fv(GLuint(index),&v0)
    }
    
    public func vertexAttribPointer(index: Int32, size: Int32, type: Int32, normalized: Bool, stride: Int32, offset: Int) {
        let ptr = BUFFER_OFFSET(n: offset)
        glVertexAttribPointer(GLuint(index), size, GLenum(type), boolConverter(value: normalized), stride, ptr)
    }
    
    
    public func viewport(x: Int32, y: Int32, width: Int32, height: Int32){
        glViewport(x, y, width, height)
    }
    
    

        /* Clearing buffers */

        public var DEPTH_BUFFER_BIT : Int32 { return GL_DEPTH_BUFFER_BIT }

        public var COLOR_BUFFER_BIT : Int32 { return GL_COLOR_BUFFER_BIT }

        public var STENCIL_BUFFER_BIT : Int32 { return GL_STENCIL_BUFFER_BIT }

        /* Clearing buffers */

        /* Rendering primitives */

        public var POINTS : Int32 { return GL_POINTS }

        public var LINES : Int32 { return GL_LINES }

        public var LINE_LOOP : Int32 { return GL_LINE_LOOP }

        public var LINE_STRIP : Int32 { return GL_LINE_STRIP }

        public var TRIANGLES : Int32 { return GL_TRIANGLES }

        public var TRIANGLE_STRIP : Int32 { return GL_TRIANGLE_STRIP }

        public var TRIANGLE_FAN : Int32 { return GL_TRIANGLE_FAN }

        /* Rendering primitives */

        /* Blending modes */


        public var ONE : Int32 { return GL_ONE }

        public var ZERO : Int32 { return GL_ZERO }
        public var SRC_COLOR : Int32 { return GL_SRC_COLOR }

        public var ONE_MINUS_SRC_COLOR : Int32 { return GL_ONE_MINUS_SRC_COLOR }

        public var SRC_ALPHA : Int32 { return GL_SRC_ALPHA }

        public var ONE_MINUS_SRC_ALPHA : Int32 { return GL_ONE_MINUS_SRC_ALPHA }

        public var DST_ALPHA : Int32 { return GL_DST_ALPHA }

        public var ONE_MINUS_DST_ALPHA : Int32 { return GL_ONE_MINUS_DST_ALPHA }

        public var DST_COLOR : Int32 { return GL_DST_COLOR }

        public var ONE_MINUS_DST_COLOR : Int32 { return GL_ONE_MINUS_DST_COLOR }

        public var SRC_ALPHA_SATURATE : Int32 { return GL_SRC_ALPHA_SATURATE }

        public var CONSTANT_COLOR : Int32 { return GL_CONSTANT_COLOR }
        public var ONE_MINUS_CONSTANT_COLOR : Int32 { return GL_ONE_MINUS_CONSTANT_COLOR }

        public var CONSTANT_ALPHA : Int32 { return GL_CONSTANT_ALPHA }
        public var ONE_MINUS_CONSTANT_ALPHA : Int32 { return GL_ONE_MINUS_CONSTANT_ALPHA }

        /* Blending modes */

        /* Blending equations */
        public var FUNC_ADD : Int32 { return GL_FUNC_ADD }

        public var FUNC_SUBTRACT : Int32 { return GL_FUNC_SUBTRACT }

        public var FUNC_REVERSE_SUBTRACT : Int32 { return GL_FUNC_REVERSE_SUBTRACT }

        /* Blending equations */


        /* Getting GL parameter information */

        public var BLEND_EQUATION : Int32 { return GL_BLEND_EQUATION }

        public var BLEND_EQUATION_RGB : Int32 { return GL_BLEND_EQUATION_RGB }

        public var BLEND_EQUATION_ALPHA : Int32 { return GL_BLEND_EQUATION_ALPHA }

        public var BLEND_DST_RGB : Int32 { return GL_BLEND_DST_RGB }

        public var BLEND_SRC_RGB : Int32 { return GL_BLEND_SRC_RGB }

        public var BLEND_DST_ALPHA : Int32 { return GL_BLEND_DST_ALPHA }

        public var BLEND_SRC_ALPHA : Int32 { return GL_BLEND_SRC_ALPHA }

        public var BLEND_COLOR : Int32 { return GL_BLEND_COLOR }

        public var ARRAY_BUFFER_BINDING : Int32 { return GL_ARRAY_BUFFER_BINDING }

        public var ELEMENT_ARRAY_BUFFER_BINDING : Int32 { return GL_ELEMENT_ARRAY_BUFFER_BINDING }

        public var LINE_WIDTH : Int32 { return GL_LINE_WIDTH }

        public var ALIASED_POINT_SIZE_RANGE : Int32 { return GL_ALIASED_POINT_SIZE_RANGE }

        public var ALIASED_LINE_WIDTH_RANGE : Int32 { return GL_ALIASED_LINE_WIDTH_RANGE }

        public var CULL_FACE_MODE : Int32 { return GL_CULL_FACE_MODE }

        public var FRONT_FACE : Int32 { return GL_FRONT_FACE }

        public var DEPTH_RANGE : Int32 { return GL_DEPTH_RANGE }

        public var DEPTH_WRITEMASK : Int32 { return GL_DEPTH_WRITEMASK }

        public var DEPTH_CLEAR_VALUE : Int32 { return GL_DEPTH_CLEAR_VALUE }

        public var DEPTH_FUNC : Int32 { return GL_DEPTH_FUNC }

        public var STENCIL_CLEAR_VALUE : Int32 { return GL_STENCIL_CLEAR_VALUE }

        public var STENCIL_FUNC : Int32 { return GL_STENCIL_FUNC }

        public var STENCIL_FAIL : Int32 { return GL_STENCIL_FAIL }

        public var STENCIL_PASS_DEPTH_FAIL : Int32 { return GL_STENCIL_PASS_DEPTH_FAIL }

        public var STENCIL_PASS_DEPTH_PASS : Int32 { return GL_STENCIL_PASS_DEPTH_PASS }

        public var STENCIL_REF : Int32 { return GL_STENCIL_REF }

        public var STENCIL_VALUE_MASK : Int32 { return GL_STENCIL_VALUE_MASK }

        public var STENCIL_WRITEMASK : Int32 { return GL_STENCIL_WRITEMASK }

        public var STENCIL_BACK_FUNC : Int32 { return GL_STENCIL_BACK_FUNC }

        public var STENCIL_BACK_FAIL : Int32 { return GL_STENCIL_BACK_FAIL }

        public var STENCIL_BACK_PASS_DEPTH_FAIL : Int32 { return GL_STENCIL_BACK_PASS_DEPTH_FAIL }

        public var STENCIL_BACK_PASS_DEPTH_PASS : Int32 { return GL_STENCIL_BACK_PASS_DEPTH_PASS }

        public var STENCIL_BACK_REF : Int32 { return GL_STENCIL_BACK_REF }

        public var STENCIL_BACK_VALUE_MASK : Int32 { return GL_STENCIL_BACK_VALUE_MASK }

        public var STENCIL_BACK_WRITEMASK : Int32 { return GL_STENCIL_BACK_WRITEMASK }

        public var VIEWPORT : Int32 { return GL_VIEWPORT }

        public var SCISSOR_BOX : Int32 { return GL_SCISSOR_BOX }

        public var COLOR_CLEAR_VALUE : Int32 { return GL_COLOR_CLEAR_VALUE }

        public var COLOR_WRITEMASK : Int32 { return GL_COLOR_WRITEMASK }

        public var UNPACK_ALIGNMENT : Int32 { return GL_UNPACK_ALIGNMENT }

        public var PACK_ALIGNMENT : Int32 { return GL_PACK_ALIGNMENT }

        public var MAX_TEXTURE_SIZE : Int32 { return GL_MAX_TEXTURE_SIZE }

        public var MAX_VIEWPORT_DIMS : Int32 { return GL_MAX_VIEWPORT_DIMS }

        public var SUBPIXEL_BITS : Int32 { return GL_SUBPIXEL_BITS }

        public var RED_BITS : Int32 { return GL_RED_BITS }

        public var GREEN_BITS : Int32 { return GL_GREEN_BITS }

        public var BLUE_BITS : Int32 { return GL_BLUE_BITS }

        public var ALPHA_BITS : Int32 { return GL_ALPHA_BITS }

        public var DEPTH_BITS : Int32 { return GL_DEPTH_BITS }

        public var STENCIL_BITS : Int32 { return GL_STENCIL_BITS }

        public var POLYGON_OFFSET_UNITS : Int32 { return GL_POLYGON_OFFSET_UNITS }

        public var POLYGON_OFFSET_FACTOR : Int32 { return GL_POLYGON_OFFSET_FACTOR }

        public var TEXTURE_BINDING_2D : Int32 { return GL_TEXTURE_BINDING_2D }

        public var SAMPLE_BUFFERS : Int32 { return GL_SAMPLE_BUFFERS }

        public var SAMPLES : Int32 { return GL_SAMPLES }

        public var SAMPLE_COVERAGE_VALUE : Int32 { return GL_SAMPLE_COVERAGE_VALUE }

        public var SAMPLE_COVERAGE_INVERT : Int32 { return GL_SAMPLE_COVERAGE_INVERT }

        public var COMPRESSED_TEXTURE_FORMATS : Int32 { return GL_COMPRESSED_TEXTURE_FORMATS }

        public var VENDOR : Int32 { return GL_VENDOR }

        public var RENDERER : Int32 { return GL_RENDERER }

        public var VERSION : Int32 { return GL_VERSION }

        public var IMPLEMENTATION_COLOR_READ_TYPE : Int32 { return GL_IMPLEMENTATION_COLOR_READ_TYPE }

        public var IMPLEMENTATION_COLOR_READ_FORMAT : Int32 { return GL_IMPLEMENTATION_COLOR_READ_FORMAT }

        public var BROWSER_DEFAULT_WEBGL : Int32 { return  0x9244 }

        /* Getting GL parameter information */

        /* Buffers */

        public var STATIC_DRAW : Int32 { return GL_STATIC_DRAW }

        public var STREAM_DRAW : Int32 { return GL_STREAM_DRAW }

        public var DYNAMIC_DRAW : Int32 { return GL_DYNAMIC_DRAW }

        public var ARRAY_BUFFER : Int32 { return GL_ARRAY_BUFFER }

        public var ELEMENT_ARRAY_BUFFER : Int32 { return GL_ELEMENT_ARRAY_BUFFER }

        public var BUFFER_SIZE : Int32 { return GL_BUFFER_SIZE }

        public var BUFFER_USAGE : Int32 { return GL_BUFFER_USAGE }

        /* Buffers */

        /* Vertex attributes */

        public var CURRENT_VERTEX_ATTRIB : Int32 { return GL_CURRENT_VERTEX_ATTRIB }

        public var VERTEX_ATTRIB_ARRAY_ENABLED : Int32 { return GL_VERTEX_ATTRIB_ARRAY_ENABLED }

        public var VERTEX_ATTRIB_ARRAY_SIZE : Int32 { return GL_VERTEX_ATTRIB_ARRAY_SIZE }

        public var VERTEX_ATTRIB_ARRAY_STRIDE : Int32 { return GL_VERTEX_ATTRIB_ARRAY_STRIDE }

        public var VERTEX_ATTRIB_ARRAY_TYPE : Int32 { return GL_VERTEX_ATTRIB_ARRAY_TYPE }

        public var VERTEX_ATTRIB_ARRAY_NORMALIZED : Int32 { return GL_VERTEX_ATTRIB_ARRAY_NORMALIZED }

        public var VERTEX_ATTRIB_ARRAY_POINTER : Int32 { return GL_VERTEX_ATTRIB_ARRAY_POINTER }

        public var VERTEX_ATTRIB_ARRAY_BUFFER_BINDING : Int32 { return GL_VERTEX_ATTRIB_ARRAY_BUFFER_BINDING }

        /* Vertex attributes */

        /* Culling */

        public var CULL_FACE : Int32 { return GL_CULL_FACE }

        public var FRONT : Int32 { return GL_FRONT }

        public var BACK : Int32 { return GL_BACK }

        public var FRONT_AND_BACK : Int32 { return GL_FRONT_AND_BACK }

        /* Culling */

        /* Enabling and disabling */

        public var BLEND : Int32 { return GL_BLEND }

        public var DEPTH_TEST : Int32 { return GL_DEPTH_TEST }

        public var DITHER : Int32 { return GL_DITHER }

        public var POLYGON_OFFSET_FILL : Int32 { return GL_POLYGON_OFFSET_FILL }

        public var SAMPLE_ALPHA_TO_COVERAGE : Int32 { return GL_SAMPLE_ALPHA_TO_COVERAGE }

        public var SAMPLE_COVERAGE : Int32 { return GL_SAMPLE_COVERAGE }

        public var SCISSOR_TEST : Int32 { return GL_SCISSOR_TEST }

        public var STENCIL_TEST : Int32 { return GL_STENCIL_TEST }

        /* Enabling and disabling */

        /* Errors */
        public var NO_ERROR : Int32 { return GL_NO_ERROR }

        public var INVALID_ENUM : Int32 { return GL_INVALID_ENUM }

        public var INVALID_VALUE : Int32 { return GL_INVALID_VALUE }

        public var INVALID_OPERATION : Int32 { return GL_INVALID_OPERATION }

        public var INVALID_FRAMEBUFFER_OPERATION : Int32 { return GL_INVALID_FRAMEBUFFER_OPERATION }

        public var OUT_OF_MEMORY : Int32 { return GL_OUT_OF_MEMORY }

        public var CONTEXT_LOST_WEBGL: Int32 { return 0x9242 }
        /* Errors */

        /* Front face directions */

        public var CW : Int32 { return GL_CW }

        public var CCW : Int32 { return GL_CCW }

        /* Front face directions */


        /* Hints */

        public var DONT_CARE : Int32 { return GL_DONT_CARE }

        public var FASTEST : Int32 { return GL_FASTEST }

        public var NICEST : Int32 { return GL_NICEST }

        public var GENERATE_MIPMAP_HINT : Int32 { return GL_GENERATE_MIPMAP_HINT }

        /* Hints */


        /* Data types */

        public var BYTE : Int32 { return GL_BYTE }

        public var UNSIGNED_BYTE : Int32 { return GL_UNSIGNED_BYTE }

        public var UNSIGNED_SHORT : Int32 { return GL_UNSIGNED_SHORT }

        public var SHORT : Int32 { return GL_SHORT }

        public var UNSIGNED_INT : Int32 { return GL_UNSIGNED_INT }

        public var INT : Int32 { return GL_INT }

        public var FLOAT : Int32 { return GL_FLOAT }

        /* Data types */


        /* Pixel formats */

        public var DEPTH_COMPONENT : Int32 { return GL_DEPTH_COMPONENT }

        public var ALPHA : Int32 { return GL_ALPHA }

        public var RGB : Int32 { return GL_RGB }

        public var RGBA : Int32 { return GL_RGBA }

        public var LUMINANCE : Int32 { return GL_LUMINANCE }

        public var LUMINANCE_ALPHA : Int32 { return GL_LUMINANCE_ALPHA }

        /* Pixel formats */

        /* Pixel types */

        // public var UNSIGNED_BYTE : Int32 { return GL_UNSIGNED_BYTE }

        public var UNSIGNED_SHORT_4_4_4_4 : Int32 { return GL_UNSIGNED_SHORT_4_4_4_4 }

        public var UNSIGNED_SHORT_5_5_5_1 : Int32 { return GL_UNSIGNED_SHORT_5_5_5_1 }

        public var UNSIGNED_SHORT_5_6_5 : Int32 { return GL_UNSIGNED_SHORT_5_6_5 }

        /* Pixel types */

        /* Shaders */

        public var FRAGMENT_SHADER : Int32 { return GL_FRAGMENT_SHADER }

        public var VERTEX_SHADER : Int32 { return GL_VERTEX_SHADER }

        public var COMPILE_STATUS : Int32 { return GL_COMPILE_STATUS }

        public var DELETE_STATUS : Int32 { return GL_DELETE_STATUS }

        public var LINK_STATUS : Int32 { return GL_LINK_STATUS }

        public var VALIDATE_STATUS : Int32 { return GL_VALIDATE_STATUS }

        public var ATTACHED_SHADERS : Int32 { return GL_ATTACHED_SHADERS }

        public var ACTIVE_ATTRIBUTES : Int32 { return GL_ACTIVE_ATTRIBUTES }

        public var ACTIVE_UNIFORMS : Int32 { return GL_ACTIVE_UNIFORMS }

        public var MAX_VERTEX_UNIFORM_VECTORS : Int32 { return GL_MAX_VERTEX_UNIFORM_VECTORS }

        public var MAX_VARYING_VECTORS : Int32 { return GL_MAX_VARYING_VECTORS }

        public var MAX_COMBINED_TEXTURE_IMAGE_UNITS : Int32 { return GL_MAX_COMBINED_TEXTURE_IMAGE_UNITS }

        public var MAX_VERTEX_TEXTURE_IMAGE_UNITS : Int32 { return GL_MAX_VERTEX_TEXTURE_IMAGE_UNITS }

        public var MAX_TEXTURE_IMAGE_UNITS : Int32 { return GL_MAX_TEXTURE_IMAGE_UNITS }

        public var MAX_VERTEX_ATTRIBS : Int32 { return GL_MAX_VERTEX_ATTRIBS }

        public var MAX_FRAGMENT_UNIFORM_VECTORS : Int32 { return GL_MAX_FRAGMENT_UNIFORM_VECTORS }

        public var SHADER_TYPE : Int32 { return GL_SHADER_TYPE }

        public var SHADING_LANGUAGE_VERSION : Int32 { return GL_SHADING_LANGUAGE_VERSION }

        public var CURRENT_PROGRAM : Int32 { return GL_CURRENT_PROGRAM }

        /* Shaders */

        /* Depth or stencil tests */

        public var NEVER : Int32 { return GL_NEVER }

        public var LESS : Int32 { return GL_LESS }

        public var EQUAL : Int32 { return GL_EQUAL }

        public var LEQUAL : Int32 { return GL_LEQUAL }

        public var GREATER : Int32 { return GL_GREATER }

        public var NOTEQUAL : Int32 { return GL_NOTEQUAL }

        public var GEQUAL : Int32 { return GL_GEQUAL }

        public var ALWAYS : Int32 { return GL_ALWAYS }

        /* Depth or stencil tests */

        /* Stencil actions */

        public var KEEP : Int32 { return GL_KEEP }

        public var REPLACE : Int32 { return GL_REPLACE }

        public var INCR : Int32 { return GL_INCR }

        public var DECR : Int32 { return GL_DECR }

        public var INVERT : Int32 { return GL_INVERT }

        public var INCR_WRAP : Int32 { return GL_INCR_WRAP }

        public var DECR_WRAP : Int32 { return GL_DECR_WRAP }

        /* Stencil actions */

        /* Textures */

        public var NEAREST : Int32 { return GL_NEAREST }

        public var LINEAR : Int32 { return GL_LINEAR }

        public var NEAREST_MIPMAP_NEAREST : Int32 { return GL_NEAREST_MIPMAP_NEAREST }

        public var LINEAR_MIPMAP_NEAREST : Int32 { return GL_LINEAR_MIPMAP_NEAREST }

        public var NEAREST_MIPMAP_LINEAR : Int32 { return GL_NEAREST_MIPMAP_LINEAR }

        public var LINEAR_MIPMAP_LINEAR : Int32 { return GL_LINEAR_MIPMAP_LINEAR }

        public var TEXTURE_MAG_FILTER : Int32 { return GL_TEXTURE_MAG_FILTER }

        public var TEXTURE_MIN_FILTER : Int32 { return GL_TEXTURE_MIN_FILTER }

        public var TEXTURE_WRAP_S : Int32 { return GL_TEXTURE_WRAP_S }

        public var TEXTURE_WRAP_T : Int32 { return GL_TEXTURE_WRAP_T }

        public var TEXTURE_2D : Int32 { return GL_TEXTURE_2D }

        public var TEXTURE : Int32 { return GL_TEXTURE }

        public var TEXTURE_CUBE_MAP : Int32 { return GL_TEXTURE_CUBE_MAP }

        public var TEXTURE_BINDING_CUBE_MAP : Int32 { return GL_TEXTURE_BINDING_CUBE_MAP }

        public var TEXTURE_CUBE_MAP_POSITIVE_X : Int32 { return GL_TEXTURE_CUBE_MAP_POSITIVE_X }

        public var TEXTURE_CUBE_MAP_NEGATIVE_X : Int32 { return GL_TEXTURE_CUBE_MAP_NEGATIVE_X }

        public var TEXTURE_CUBE_MAP_POSITIVE_Y : Int32 { return GL_TEXTURE_CUBE_MAP_POSITIVE_Y }

        public var TEXTURE_CUBE_MAP_NEGATIVE_Y : Int32 { return GL_TEXTURE_CUBE_MAP_NEGATIVE_Y }

        public var TEXTURE_CUBE_MAP_POSITIVE_Z : Int32 { return GL_TEXTURE_CUBE_MAP_POSITIVE_Z }

        public var TEXTURE_CUBE_MAP_NEGATIVE_Z : Int32 { return GL_TEXTURE_CUBE_MAP_NEGATIVE_Z }

        public var MAX_CUBE_MAP_TEXTURE_SIZE : Int32 { return GL_MAX_CUBE_MAP_TEXTURE_SIZE }

        public var TEXTURE0 : Int32 { return GL_TEXTURE0 }

        public var TEXTURE1 : Int32 { return GL_TEXTURE1 }

        public var TEXTURE2 : Int32 { return GL_TEXTURE2 }

        public var TEXTURE3 : Int32 { return GL_TEXTURE3 }

        public var TEXTURE4 : Int32 { return GL_TEXTURE4 }

        public var TEXTURE5 : Int32 { return GL_TEXTURE5 }

        public var TEXTURE6 : Int32 { return GL_TEXTURE6 }

        public var TEXTURE7 : Int32 { return GL_TEXTURE7 }

        public var TEXTURE8 : Int32 { return GL_TEXTURE8 }

        public var TEXTURE9 : Int32 { return GL_TEXTURE9 }

        public var TEXTURE10 : Int32 { return GL_TEXTURE10 }

        public var TEXTURE11 : Int32 { return GL_TEXTURE11 }

        public var TEXTURE12 : Int32 { return GL_TEXTURE12 }

        public var TEXTURE13 : Int32 { return GL_TEXTURE13 }

        public var TEXTURE14 : Int32 { return GL_TEXTURE14 }

        public var TEXTURE15 : Int32 { return GL_TEXTURE15 }

        public var TEXTURE16 : Int32 { return GL_TEXTURE16 }

        public var TEXTURE17 : Int32 { return GL_TEXTURE17 }

        public var TEXTURE18 : Int32 { return GL_TEXTURE18 }

        public var TEXTURE19 : Int32 { return GL_TEXTURE19 }

        public var TEXTURE20 : Int32 { return GL_TEXTURE20 }

        public var TEXTURE21 : Int32 { return GL_TEXTURE21 }

        public var TEXTURE22 : Int32 { return GL_TEXTURE22 }

        public var TEXTURE23 : Int32 { return GL_TEXTURE23 }

        public var TEXTURE24 : Int32 { return GL_TEXTURE24 }

        public var TEXTURE25 : Int32 { return GL_TEXTURE25 }

        public var TEXTURE26 : Int32 { return GL_TEXTURE26 }

        public var TEXTURE27 : Int32 { return GL_TEXTURE27 }

        public var TEXTURE28 : Int32 { return GL_TEXTURE28 }

        public var TEXTURE29 : Int32 { return GL_TEXTURE29 }

        public var TEXTURE30 : Int32 { return GL_TEXTURE30 }

        public var TEXTURE31 : Int32 { return GL_TEXTURE31 }

        public var ACTIVE_TEXTURE : Int32 { return GL_ACTIVE_TEXTURE }

        public var REPEAT : Int32 { return GL_REPEAT }

        public var CLAMP_TO_EDGE : Int32 { return GL_CLAMP_TO_EDGE }

        public var MIRRORED_REPEAT : Int32 { return GL_MIRRORED_REPEAT }

        /* Textures */



        /* Uniform types */

        public var FLOAT_VEC2 : Int32 { return GL_FLOAT_VEC2 }

        public var FLOAT_VEC3 : Int32 { return GL_FLOAT_VEC3 }

        public var FLOAT_VEC4 : Int32 { return GL_FLOAT_VEC4 }

        public var INT_VEC2 : Int32 { return GL_INT_VEC2 }

        public var INT_VEC3 : Int32 { return GL_INT_VEC3 }

        public var INT_VEC4 : Int32 { return GL_INT_VEC4 }


        public var BOOL : Int32 { return GL_BOOL }


        public var BOOL_VEC2 : Int32 { return GL_BOOL_VEC2 }

        public var BOOL_VEC3 : Int32 { return GL_BOOL_VEC3 }

        public var BOOL_VEC4 : Int32 { return GL_BOOL_VEC4 }


        public var FLOAT_MAT2 : Int32 { return GL_FLOAT_MAT2 }


        public var FLOAT_MAT3 : Int32 { return GL_FLOAT_MAT3 }


        public var FLOAT_MAT4 : Int32 { return GL_FLOAT_MAT4 }

        public var SAMPLER_2D : Int32 { return GL_SAMPLER_2D }

        public var SAMPLER_CUBE : Int32 { return GL_SAMPLER_CUBE }

        /* Uniform types */

        /* Shader precision-specified types */

        public var LOW_FLOAT : Int32 { return GL_LOW_FLOAT }
        public var MEDIUM_FLOAT : Int32 { return GL_MEDIUM_FLOAT }
        public var HIGH_FLOAT : Int32 { return GL_HIGH_FLOAT }
        public var LOW_INT : Int32 { return GL_LOW_INT }
        public var MEDIUM_INT : Int32 { return GL_MEDIUM_INT }
        public var HIGH_INT : Int32 { return GL_HIGH_INT }

        /* Shader precision-specified types */


        /* Framebuffers and renderbuffers */

        public var FRAMEBUFFER : Int32 { return GL_FRAMEBUFFER }

        public var RENDERBUFFER : Int32 { return GL_RENDERBUFFER }

        public var RGBA4 : Int32 { return GL_RGBA4 }

        public var RGB565 : Int32 { return GL_RGB565 }

        public var RGB5_A1 : Int32 { return GL_RGB5_A1 }

        public var DEPTH_COMPONENT16 : Int32 { return GL_DEPTH_COMPONENT16 }

        public var STENCIL_INDEX8 : Int32 { return GL_STENCIL_INDEX8 }

        public var DEPTH_STENCIL : Int32 { return  0x84F9 }

        public var RENDERBUFFER_WIDTH : Int32 { return GL_RENDERBUFFER_WIDTH }

        public var RENDERBUFFER_HEIGHT : Int32 { return GL_RENDERBUFFER_HEIGHT }

        public var RENDERBUFFER_INTERNAL_FORMAT : Int32 { return GL_RENDERBUFFER_INTERNAL_FORMAT }

        public var RENDERBUFFER_RED_SIZE : Int32 { return GL_RENDERBUFFER_RED_SIZE }

        public var RENDERBUFFER_GREEN_SIZE : Int32 { return GL_RENDERBUFFER_GREEN_SIZE }

        public var RENDERBUFFER_BLUE_SIZE : Int32 { return GL_RENDERBUFFER_BLUE_SIZE }

        public var RENDERBUFFER_ALPHA_SIZE : Int32 { return GL_RENDERBUFFER_ALPHA_SIZE }

        public var RENDERBUFFER_DEPTH_SIZE : Int32 { return GL_RENDERBUFFER_DEPTH_SIZE }

        public var RENDERBUFFER_STENCIL_SIZE : Int32 { return GL_RENDERBUFFER_STENCIL_SIZE }

        public var FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE : Int32 { return GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE }

        public var FRAMEBUFFER_ATTACHMENT_OBJECT_NAME : Int32 { return GL_FRAMEBUFFER_ATTACHMENT_OBJECT_NAME }

        public var FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL : Int32 { return GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LEVEL }

        public var FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE : Int32 { return GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_CUBE_MAP_FACE }

        public var COLOR_ATTACHMENT0 : Int32 { return GL_COLOR_ATTACHMENT0 }

        public var DEPTH_ATTACHMENT : Int32 { return GL_DEPTH_ATTACHMENT }

        public var STENCIL_ATTACHMENT : Int32 { return GL_STENCIL_ATTACHMENT }

        public var DEPTH_STENCIL_ATTACHMENT: Int32 { return 0x821A }

        public var NONE : Int32 { return GL_NONE }

        public var FRAMEBUFFER_COMPLETE : Int32 { return GL_FRAMEBUFFER_COMPLETE }

        public var FRAMEBUFFER_INCOMPLETE_ATTACHMENT : Int32 { return GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT }

        public var FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT : Int32 { return GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT }

        public var FRAMEBUFFER_INCOMPLETE_DIMENSIONS : Int32 { return GL_FRAMEBUFFER_INCOMPLETE_DIMENSIONS }

        public var FRAMEBUFFER_UNSUPPORTED : Int32 { return GL_FRAMEBUFFER_UNSUPPORTED }

        public var FRAMEBUFFER_BINDING : Int32 { return GL_FRAMEBUFFER_BINDING }

        public var RENDERBUFFER_BINDING : Int32 { return GL_RENDERBUFFER_BINDING }

        public var MAX_RENDERBUFFER_SIZE : Int32 { return GL_MAX_RENDERBUFFER_SIZE }

        //public var INVALID_FRAMEBUFFER_OPERATION : Int32 { return GL_INVALID_FRAMEBUFFER_OPERATION }

        /* Framebuffers and renderbuffers */

        /* Pixel storage modes */

        public var UNPACK_COLORSPACE_CONVERSION_WEBGL : Int32 { 0x9243 }

        public var UNPACK_FLIP_Y_WEBGL : Int32 { return  0x9240 }

        public var UNPACK_PREMULTIPLY_ALPHA_WEBGL : Int32 { return  0x9241 }

        /* Pixel storage modes */
    
   
}
