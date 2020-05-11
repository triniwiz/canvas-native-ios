//
//  WebGL2RenderingContext.swift
//  CanvasNative
//
//  Created by Osei Fortune on 4/29/20.
//

import Foundation
import UIKit
import GLKit
@objcMembers
@objc(WebGL2RenderingContext)
public class WebGL2RenderingContext: WebGLRenderingContext {
    public override init(canvas: Canvas) {
        super.init(canvas: canvas)
    }
    
    public override init(canvas: Canvas, attrs: [String: Any]) {
        super.init(canvas: canvas, attrs: attrs)
    }
    
    public func beginQuery(target: Int32, query: UInt32){
        glBeginQuery(GLenum(target), query)
    }
    
    public func beginTransformFeedback(primitiveMode: Int32){
        glBeginTransformFeedback(GLenum(primitiveMode))
    }
    
    public func bindBufferBase(target: Int32, index: UInt32, buffer: UInt32) {
        glBindBufferBase(GLenum(target), index, buffer)
    }
    
    
    public func bindBufferRange(target: Int32, index: UInt32, buffer: UInt32, offset: Int, size: Int){
        glBindBufferRange(GLenum(target), index, buffer, offset, size)
    }
    
    
    public func bindSampler(unit: UInt32, sampler: UInt32){
        glBindSampler(unit, sampler)
    }
    
    public func bindTransformFeedback(target: Int32, transformFeedback: UInt32){
        glBindTransformFeedback(GLenum(target), transformFeedback)
    }
    
    public func bindVertexArray(vertexArray: UInt32){
        glBindVertexArray(vertexArray)
    }
    
    public func blitFramebuffer(srcX0: Int32, srcY0: Int32, srcX1: Int32, srcY1: Int32,
                                dstX0:Int32, dstY0: Int32, dstX1:Int32, dstY1:Int32,
                                mask: Int32, filter: Int32){
        glBlitFramebuffer(srcX0, srcY0, srcX1, srcY1, dstX0, dstY0, dstX1, dstY1, GLbitfield(mask), GLenum(filter))
    }
    
    public func clearBufferfv(buffer: Int32, drawbuffer: Int32, values: [Float]){
        var value = values
        glClearBufferfv(GLenum(buffer), drawbuffer, &value)
    }
    
    public func clearBufferiv(buffer: Int32, drawbuffer: Int32, values: [Int32]){
        var value = values
        glClearBufferiv(GLenum(buffer), drawbuffer, &value)
    }
    
    public func clearBufferuiv(buffer: Int32, drawbuffer: Int32, values: [UInt32]){
        var value = values
        glClearBufferuiv(GLenum(buffer), drawbuffer, &value)
    }
    
    public func clearBufferfi(buffer: Int32, drawbuffer: Int32, depth: Float, stencil: Int32){
        glClearBufferfi(GLenum(buffer), drawbuffer, depth, stencil)
    }
    
    public func clientWaitSync(sync: GLsync, flags: Int32, timeout: UInt64) -> Int32{
        return Int32(glClientWaitSync(sync, GLbitfield(flags), timeout))
    }
    
    public func compressedTexSubImage3D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, zoffset: Int32, width: Int32, height: Int32, depth: Int32, format: Int32, imageSize: Int32, offset: Int32){
        glCompressedTexSubImage3D(GLenum(target), level, xoffset, yoffset, zoffset, width, height, depth, GLenum(format), imageSize, BUFFER_OFFSET(n: Int(offset)))
    }
    
    public func compressedTexSubImage3D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, zoffset: Int32, width: Int32, height: Int32, depth: Int32, format: Int32, srcData: [UInt8], srcOffset: Int32, srcLengthOverride: Int32){
           var size = Int32(SIZE_OF_BYTE * srcData.count)
           let offset = Int32(srcOffset * Int32(SIZE_OF_BYTE))
           let overrideLength = Int32(srcLengthOverride * Int32(SIZE_OF_BYTE))
           if(srcLengthOverride == 0){
               size = size - offset
           }else if(overrideLength > size - offset) {
               
           }
           var buffer = srcData
            offsetBy(&buffer, offset)
           glCompressedTexSubImage3D(GLenum(target), level, xoffset, yoffset, zoffset, width, height, depth, GLenum(format), overrideLength, buffer)
       }
    
    enum DataType {
        case Byte
        case Int
        case Short
        case UShort
        case Float
        case Int32
        case UInt32
        case Float64
    }
    
    
    
    public func copyBufferSubData(readTarget: Int32, writeTarget: Int32, readOffset: Int, writeOffset: Int, size: Int) {
        glCopyBufferSubData(GLenum(readTarget), GLenum(writeTarget), GLintptr(readOffset), GLintptr(writeOffset), GLsizeiptr(size))
    }
    
    public func copyTexSubImage3D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, zoffset: Int32, x: Int32, y: Int32, width: Int32, height: Int32){
        glCopyTexSubImage3D(GLenum(target), level, xoffset, yoffset, zoffset, x, y, width, height)
    }
    
    public func createQuery() -> UInt32 {
        var query = GLuint()
        glGenQueries(1, &query)
        return query
    }
    
    public func createSampler() -> UInt32 {
        var sampler = GLuint()
        glGenSamplers(1, &sampler)
        return sampler
    }
    
    public func createVertexArray() -> UInt32{
        var array = GLuint()
        glGenVertexArrays(1, &array)
        return array
    }
    
    public func createTransformFeedback() -> UInt32{
        var id = GLuint()
        glGenTransformFeedbacks(1, &id)
        return id
    }
    
    public func deleteQuery(query: UInt32) {
        var id = query
        glDeleteQueries(1, &id)
    }
    
    public func deleteSampler(sampler: UInt32){
        var id = sampler
        glDeleteQueries(1, &id)
    }
    
    public func deleteSync(sync: GLsync){
        glDeleteSync(sync)
    }
    
    public func deleteTransformFeedback(transformFeedback: UInt32){
        var feedback = transformFeedback
        glDeleteTransformFeedbacks(1, &feedback)
    }
    
    public func deleteVertexArray(vertexArray: UInt32){
        var array = vertexArray
        glDeleteVertexArrays(1, &array)
    }
    
    public func drawArraysInstanced(mode: Int32, first: Int32, count: Int32, instanceCount: Int32){
        glDrawArraysInstanced(GLenum(mode), first, count, instanceCount)
    }
    
    public func drawBuffers(buffers: [Int32]){
        var bufs = buffers.map { buf -> UInt32 in
            return UInt32(buf)
        }
        glDrawBuffers(GLsizei(bufs.count), &bufs)
    }
    
    public func drawElementsInstanced(mode: Int32, count: Int32, type: Int32, offset: Int, instanceCount: Int32){
        var indices = offset
        glDrawElementsInstanced(GLenum(mode), count, GLenum(type), &indices, instanceCount)
    }
    
    public func drawRangeElements(mode: Int32, start: Int32, end: Int32, count: Int32, type: Int32, offset: Int) {
        var indices = offset
        glDrawRangeElements(GLenum(mode), GLuint(start), GLuint(end), count, GLenum(type), &indices)
    }
    
    public func endQuery(target: Int32){
        glEndQuery(GLenum(target))
    }
    public func endTransformFeedback(){
        glEndTransformFeedback()
    }
    public func fenceSync(condition: Int32, flags: Int32) {
        glFenceSync(GLenum(condition), GLbitfield(flags))
    }
    
    public func framebufferTextureLayer(target: Int32, attachment: Int32, texture: UInt32, level: Int32, layer: Int32){
        glFramebufferTextureLayer(GLenum(target), GLenum(attachment), texture, level, layer)
    }
    
    public func getActiveUniformBlockName(program: UInt32, uniformBlockIndex: UInt32) -> String {
        var maxNameLength = GLint()
        glGetProgramiv(program, GLenum(GL_ACTIVE_UNIFORM_BLOCK_MAX_NAME_LENGTH), &maxNameLength)
        var name = Array(repeating: GLchar(), count: Int(maxNameLength))
        var length = GLint()
        glGetActiveUniformBlockName(program, uniformBlockIndex, maxNameLength, &length, &name)
        return String(cString: &name)
    }
    
    public func getActiveUniformBlockParameter(program: UInt32, uniformBlockIndex: UInt32, pname: Int32) -> Any {
        switch (pname) {
        case GL_UNIFORM_BLOCK_BINDING, GL_UNIFORM_BLOCK_DATA_SIZE, GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS:
            var intValue = GLint()
            glGetActiveUniformBlockiv(program, uniformBlockIndex, GLenum(pname), &intValue)
            return intValue
        case GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES:
            var uniformCount = GLint()
            glGetActiveUniformBlockiv(program, uniformBlockIndex, GLenum(GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS), &uniformCount)
            var indices = Array(repeating: GLint(), count: Int(uniformCount))
            glGetActiveUniformBlockiv(program, uniformBlockIndex,GLenum(pname),&indices)
            return indices
        case GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER, GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER:
            var boolValue = GLint()
            glGetActiveUniformBlockiv(program, uniformBlockIndex, GLenum(pname), &boolValue)
            return toBool(value: boolValue)
        default:
            return NSNull()
        }
        
    }
    
    enum ReturnType {
        case EnumType
        case UnsignedIntType
        case IntType
        case BoolType
    }
    
    public func getActiveUniforms(program: UInt32, uniformIndices: [UInt32], pname: Int32) -> Any {
        
        var returnType: ReturnType
        switch (pname) {
        case GL_UNIFORM_TYPE:
            returnType = .EnumType
            break
        case GL_UNIFORM_SIZE:
            returnType = .UnsignedIntType
            break;
        case GL_UNIFORM_BLOCK_INDEX, GL_UNIFORM_OFFSET, GL_UNIFORM_ARRAY_STRIDE, GL_UNIFORM_MATRIX_STRIDE:
            returnType = .IntType
            break;
        case GL_UNIFORM_IS_ROW_MAJOR:
            returnType = .BoolType
            break;
        default:
            return NSNull()
        }
        
        var activeUniforms = GLint(-1)
        glGetProgramiv(program, GLenum(GL_ACTIVE_UNIFORMS),
                       &activeUniforms)
        
        
        let activeUniformsUnsigned = activeUniforms
        let size = uniformIndices.count
        for i in uniformIndices {
            if (i >= activeUniformsUnsigned) {
                return NSNull()
            }
        }
        
        var indices = uniformIndices
        var result = Array(repeating: GLint(), count: size)
        glGetActiveUniformsiv(program, GLsizei(uniformIndices.count),
                              &indices, GLenum(pname), &result)
        
        switch (returnType) {
        case .EnumType:
            return result
        case .UnsignedIntType:
            return result
        case .IntType:
            // Convert ?
            return result
        case .BoolType:
            return fromGLint(value: result)
        }
        
    }
    
    
    public func getBufferSubData(target: Int32, srcByteOffset: Int, dstData: [UInt8], dstOffset: Int32, length: Int32) {
        if(length == 0){
            
        }
        
        let size = dstData.count * SIZE_OF_BYTE
        let typeSize = SIZE_OF_BYTE
        var byteLength = 0
        if (length > 0) {
            // type size is at most 8, so no overflow.
            byteLength = Int(length) * typeSize
        }
        var byteOffset = 0
        if (dstOffset > 0) {
            // type size is at most 8, so no overflow.
            byteOffset = Int(dstOffset) * typeSize
        }
        var total = byteOffset
        total += byteLength;
        if (total > size) {
            return
        }
        if (byteLength == 0) {
            byteLength = size - byteOffset
        }
        
        
        // var offset = srcByteOffset * SIZE_OF_BYTE
        
        var data = dstData
        glBufferSubData(GLenum(target), byteOffset, byteLength, &data)
    }
    
    
    public func getFragDataLocation(program: UInt32, name: String)-> Int32{
        let value = (name as NSString).utf8String
        return glGetFragDataLocation(program, value)
    }
    var m_boundIndexedTransformFeedbackBuffers: [UInt32] = []
    var m_boundIndexedUniformBuffers: [UInt32] = []
    
    public func getIndexedParameter(target: Int32, index: UInt32) -> Any{
        let binding = IndexedParameter()
        switch (target) {
        case GL_TRANSFORM_FEEDBACK_BUFFER_BINDING,GL_UNIFORM_BUFFER_BINDING:
            
            var newTarget = GLint()
            glGetIntegerv(GLenum(target), &newTarget)
                                  // NO BINDING RETURN
                                  if (newTarget == 0) {
                                      return NSNull()
                                  }
                                  var buffer = GLint()
            
            glGetIntegeri_v(GLenum(newTarget), index, &buffer)
            binding._bufferValue = UInt32(buffer)
                                  binding._isBuffer = true
            
            return binding
        case GL_TRANSFORM_FEEDBACK_BUFFER_SIZE, GL_TRANSFORM_FEEDBACK_BUFFER_START, GL_UNIFORM_BUFFER_SIZE,GL_UNIFORM_BUFFER_START:
            var value = GLint64(-1);
            glGetInteger64i_v(GLenum(target), index, &value)
            binding._isBuffer = false
            binding._value = value
            return binding
        default:
            return NSNull()
        }
    }
    
    public func getInternalformatParameter(target: Int32, internalformat: Int32, pname: Int32)-> Any {
        switch (internalformat) {
            // Renderbuffer doesn't support unsized internal formats,
        // though GL_RGB and GL_RGBA are color-renderable.
        case GL_RGB,
             GL_RGBA,
             // Multisampling is not supported for signed and unsigned integer internal
        // formats.
        GL_R8UI,
        GL_R8I,
        GL_R16UI,
        GL_R16I,
        GL_R32UI,
        GL_R32I,
        GL_RG8UI,
        GL_RG8I,
        GL_RG16UI,
        GL_RG16I,
        GL_RG32UI,
        GL_RG32I,
        GL_RGBA8UI,
        GL_RGBA8I,
        GL_RGB10_A2UI,
        GL_RGBA16UI,GL_RGBA16I,GL_RGBA32UI,GL_RGBA32I:
            return Array(repeating: Int32(), count: 0)
        case GL_R8,GL_RG8,GL_RG8,GL_RGB565,GL_RGBA8,GL_SRGB8_ALPHA8,GL_RGB5_A1,
             GL_RGBA4,GL_RGB10_A2,GL_DEPTH_COMPONENT16,GL_DEPTH_COMPONENT24,
             GL_DEPTH_COMPONENT32F,
             GL_DEPTH24_STENCIL8,
             GL_DEPTH32F_STENCIL8,
             GL_STENCIL_INDEX8:
            break;
        case GL_R16F,GL_RG16F,GL_RG16F,GL_R32F,GL_RG32F,GL_RGBA32F,GL_R11F_G11F_B10F:
            break
        default:
            return NSNull()
        }
        
        
        switch (pname) {
        case GL_SAMPLES:
            var length = GLint(-1)
            glGetInternalformativ(GLenum(target), GLenum(internalformat),
                                  GLenum(GL_NUM_SAMPLE_COUNTS), 1, &length)
            if (length <= 0){
                return Array(repeating: GLint(), count: 0)
            }
            var values = Array(repeating: GLint(), count: Int(length))
            glGetInternalformativ(GLenum(target), GLenum(internalformat), GLenum(pname), length, &values)
            return values
        default:
            return NSNull()
        }
    }
    
    public func getQuery(target: Int32, pname: Int32)-> Any{
        if(pname == GL_CURRENT_QUERY){
            var params = GLint()
            glGetQueryiv(GLenum(target), GLenum(pname), &params)
            return params
        }
        return NSNull()
    }
    
    public func getQueryParameter(query: UInt32, pname: Int32) -> Any {
        var params = GLuint()
        glGetQueryObjectuiv(query, GLenum(pname), &params)
        switch (pname) {
        case GL_QUERY_RESULT:
            return params == GL_TRUE
        case GL_QUERY_RESULT_AVAILABLE:
            return params
        default:
            return NSNull()
        }
    }
    
    public func getSamplerParameter(sampler: UInt32, pname: Int32) -> Any {
        switch (pname) {
        case TEXTURE_MAX_LOD, TEXTURE_MIN_LOD:
            var floatValue = GLfloat()
            glGetSamplerParameterfv(sampler, GLenum(pname), &floatValue)
            return floatValue
        case TEXTURE_COMPARE_FUNC,TEXTURE_COMPARE_MODE,TEXTURE_MAG_FILTER,TEXTURE_MIN_FILTER,TEXTURE_WRAP_R,TEXTURE_WRAP_S,TEXTURE_WRAP_T:
            var intValue = GLint()
            glGetSamplerParameteriv(sampler, GLenum(pname), &intValue)
            return intValue
        default:
            return NSNull()
        }
    }
    
    public func getSyncParameter(sync: GLsync, pname: Int32) -> Any {
        switch(pname) {
        case GL_OBJECT_TYPE, GL_SYNC_STATUS,GL_SYNC_CONDITION,GL_SYNC_FLAGS:
            var values = GLint()
            var length = GLint(-1)
            glGetSynciv(sync, GLenum(pname), 1, &length, &values)
            return values
        default:
            return NSNull()
        }
    }
    
    public func getTransformFeedbackVarying(program: UInt32, index: UInt32) -> Any {
        // let info = WebGLActiveInfo()
        var maxIndex = GLint()
        glGetProgramiv(program,GLenum(GL_TRANSFORM_FEEDBACK_VARYINGS), &maxIndex)
        if (index >= maxIndex) {
            return NSNull()
        }
        
        var maxNameLength = GLint(-1)
        glGetProgramiv(program,GLenum(GL_TRANSFORM_FEEDBACK_VARYING_MAX_LENGTH),
                       &maxNameLength)
        if (maxNameLength <= 0) {
            return NSNull()
        }
        var name = Array(repeating: GLchar(), count: Int(maxNameLength))
        var length = GLsizei()
        var size = GLsizei()
        var type = GLenum()
        glGetTransformFeedbackVarying(program, index,
                                      maxNameLength, &length, &size, &type,
                                      &name);
        
        if (length == 0 || size == 0 || type == 0) {
            return NSNull();
        }
        
        return WebGLActiveInfo(name: String(cString: &name), size: size, type: Int32(type))
    }
    
    public func getUniformBlockIndex(program: UInt32, uniformBlockName: String) -> UInt32{
        let name = (uniformBlockName as NSString).utf8String
        return glGetUniformBlockIndex(program, name)
    }
    
    
    public func getUniformIndices(program: UInt32, uniformNames: [String]) -> [UInt32] {
        var indices = Array(repeating: UInt32(), count: uniformNames.count)
        var names = uniformNames.map { name -> UnsafePointer<Int8>? in
            return (name as NSString).utf8String
        }
        glGetUniformIndices(program, GLsizei(uniformNames.count), &names, &indices)
        return indices
    }
    
    public func invalidateFramebuffer(target: Int32, attachments: [Int32]) {
        var attach = attachments.map { att -> UInt32 in
            return UInt32(att)
        }
        glInvalidateFramebuffer(GLenum(target), GLsizei(attachments.count), &attach)
    }
    
    public func invalidateSubFramebuffer(target: Int32, attachments: [Int32], x: Int32, y: Int32, width: Int32, height: Int32) {
        var attach = attachments.map { att -> UInt32 in
            return UInt32(att)
        }
        glInvalidateSubFramebuffer(GLenum(target), GLsizei(attachments.count), &attach, x, y, width, height)
    }
    
    public func isQuery(query: UInt32) -> Bool {
        return fromGLboolean(value: glIsQuery(query))
    }
    
    public func isSampler(sampler: UInt32) -> Bool {
        return fromGLboolean(value: glIsSampler(sampler))
    }
    
    public func isSync(sync: GLsync) -> Bool {
        return fromGLboolean(value: glIsSync(sync))
    }
    
    public func isTransformFeedback(transformFeedback: UInt32) -> Bool {
        return fromGLboolean(value: glIsTransformFeedback(transformFeedback))
    }
    
    public func isVertexArray(vertexArray: UInt32) -> Bool {
        return fromGLboolean(value: glIsVertexArray(vertexArray))
    }
    
    public func pauseTransformFeedback(){
        glPauseTransformFeedback()
    }
    public func readBuffer(src: Int32){
        glReadBuffer(GLenum(src))
    }
    
    public func renderbufferStorageMultisample(target:Int32, samples:Int32, internalFormat:Int32, width:Int32, height:Int32){
        glRenderbufferStorageMultisample(GLenum(target), samples, GLenum(internalFormat), width, height)
    }
    
    public func resumeTransformFeedback(){
        glResumeTransformFeedback()
    }
    
    public func samplerParameteri(sampler: UInt32, pname: Int32, param: Int32){
        glSamplerParameteri(sampler, GLenum(pname), param)
    }
    
    public func samplerParameterf(sampler: UInt32, pname: Int32, param: Float){
        glSamplerParameterf(sampler, GLenum(pname), param)
    }
    
    public func texImage3D(target: Int32, level: Int32, internalformat: Int32, width: Int32, height: Int32, depth: Int32, border: Int32, format: Int32, type: Int32, offset: Int) {
        var pixels = offset
        glTexImage3D(GLenum(target), level, internalformat, width, height, depth, border, GLenum(format), GLenum(type), &pixels)
    }
    
    public func texImage3D(target: Int32, level: Int32, internalformat: Int32, width: Int32, height: Int32, depth: Int32, border: Int32, format: Int32, type: Int32, source: [UInt8]) {
        var pixels = source
        if(flipYWebGL){
            flipInPlace(&pixels, width, height)
        }
        glTexImage3D(GLenum(target), level, internalformat, width, height, depth, border, GLenum(format), GLenum(type), &pixels)
    }
    
    
    public func texImage3D(target: Int32, level: Int32, internalformat: Int32, width: Int32, height: Int32, depth: Int32, border: Int32, format: Int32, type: Int32,image source: UIImage) {
        let pixels = source
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
            let image_width = Int(pixels.size.width)
            let image_height = Int(pixels.size.height)
            let buffer = calloc(image_width * image_height, 4)
            let imageCtx = CGContext(data: buffer, width: image_width, height: image_height, bitsPerComponent: 8, bytesPerRow: image_width * 4, space: image.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
            imageCtx!.draw(image, in: CGRect(x: 0, y: 0, width: image_width, height: image_height))
            
            if(flipYWebGL){
                flipInPlace(buffer?.assumingMemoryBound(to: UInt8.self), Int32(image_width), Int32(image_height))
            }
            glTexImage3D(GLenum(target), level, internalformat, width, height, depth, border, GLenum(format), GLenum(type), buffer)
            buffer?.deallocate()
        }
    }
    
    
    public func texImage3D(target: Int32, level: Int32, internalformat: Int32, width: Int32, height: Int32, depth: Int32, border: Int32, format: Int32, type: Int32,asset: ImageAsset) {
        if(flipYWebGL){
            native_image_asset_flip_x_in_place_owned(UInt32(asset.width), UInt32(asset.height), asset.getRawBytes(), UInt(asset.length))
        }
        glTexImage3D(GLenum(target), level, internalformat, width, height, depth, border, GLenum(format), GLenum(type), asset.getRawBytes())
    }
    
    
    
    public func texStorage2D(target: Int32, levels: Int32, internalformat: Int32, width: Int32, height: Int32){
        glTexStorage2D(GLenum(target), levels, GLenum(internalformat), width, height)
    }
    
    public func texStorage3D(target: Int32, levels: Int32, internalformat: Int32, width: Int32, height: Int32, depth: Int32){
        glTexStorage3D(GLenum(target), levels, GLenum(internalformat), width, height, depth)
    }
    
    public func texSubImage3D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, zoffset: Int32, width: Int32, height: Int32, depth: Int32, format: Int32, type: Int32, offset: Int32){
        var pixels = offset
        glTexSubImage3D(GLenum(target), level, xoffset, yoffset, zoffset, width, height, depth, GLenum(format), GLenum(type), &pixels)
    }
    
    public func texSubImage3D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, zoffset: Int32, width: Int32, height: Int32, depth: Int32, format: Int32, type: Int32,image srcData: UIImage){
        let pixels = srcData
        
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
            let image_width = Int(pixels.size.width)
            let image_height = Int(pixels.size.height)
            let buffer = calloc(image_width * image_height, 4)
            let imageCtx = CGContext(data: buffer, width: image_width, height: image_height, bitsPerComponent: 8, bytesPerRow: image_width * 4, space: image.colorSpace!, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)
            imageCtx!.draw(image, in: CGRect(x: 0, y: 0, width: image_width, height: image_height))
            if(flipYWebGL){
                native_image_asset_flip_x_in_place_owned(UInt32(image_width), UInt32(image_height), buffer?.assumingMemoryBound(to: UInt8.self), UInt(image_width * image_height) * 4)
            }
            glTexSubImage3D(GLenum(target), level, xoffset, yoffset, zoffset, width, height, depth, GLenum(format), GLenum(type), buffer)
            buffer?.deallocate()
        }
    }
    
    
    public func texSubImage3D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, zoffset: Int32, width: Int32, height: Int32, depth: Int32, format: Int32, type: Int32, asset: ImageAsset){
      
        if(flipYWebGL){
            native_image_asset_flip_x_in_place_owned(UInt32(asset.width), UInt32(asset.height), asset.getRawBytes(), UInt(asset.length))
        }
        glTexSubImage3D(GLenum(target), level, xoffset, yoffset, zoffset, width, height, depth, GLenum(format), GLenum(type), asset.getRawBytes())
    }
    
    
    public func texSubImage3D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, zoffset: Int32, width: Int32, height: Int32, depth: Int32, format: Int32, type: Int32, srcData: [UInt8]){
        var pixels = srcData
        if(flipYWebGL){
            flipInPlace3D(&pixels, width, height,depth)
        }
        glTexSubImage3D(GLenum(target), level, xoffset, yoffset, zoffset, width, height, depth, GLenum(format), GLenum(type), &pixels)
    }
    
    public func texSubImage3D(target: Int32, level: Int32, xoffset: Int32, yoffset: Int32, zoffset: Int32, width: Int32, height: Int32, depth: Int32, format: Int32, type: Int32, srcData: [UInt8], srcOffset:Int32){
        
        var pixels = srcData
        
        offsetBy(&pixels, srcOffset)
        
        if(flipYWebGL){
            native_image_asset_flip_x_in_place_owned(UInt32(width), UInt32(height), &pixels, UInt(width * height) * 4)
        }
        glTexSubImage3D(GLenum(target), level, xoffset, yoffset, zoffset, width, height, depth, GLenum(format), GLenum(type), pixels)
    }
    
    public func transformFeedbackVaryings(program: Int32, varyings: [String], bufferMode: Int32){
        var varys = varyings.map { name -> UnsafePointer<Int8>? in
            return (name as NSString).utf8String
        }
        glTransformFeedbackVaryings(GLuint(program), GLsizei(varyings.count), &varys, GLenum(bufferMode))
    }
    
    public func uniform1ui(location: Int32, v0: UInt32){
        glUniform1ui(location, v0)
    }
    public func uniform2ui(location: Int32, v0: UInt32, v1: UInt32){
        glUniform2ui(location, v0, v1)
    }
    public func uniform3ui(location: Int32, v0: UInt32, v1: UInt32, v2: UInt32){
        glUniform3ui(location, v0, v1, v2)
    }
    public func uniform4ui(location: Int32, v0: UInt32, v1: UInt32, v2: UInt32, v3: UInt32){
        glUniform4ui(location, v0, v1, v2,v3)
    }
    
    public func uniform1uiv(location: Int32, data: [UInt32]){
        var locations = data
        glUniform1uiv(location, GLsizei(data.count), &locations)
    }
    
    public func uniform2uiv(location: Int32, data: [UInt32]){
        var locations = data
        glUniform2uiv(location, GLsizei(data.count), &locations)
    }
    public func uniform3uiv(location: Int32, data: [UInt32]){
        var locations = data
        glUniform3uiv(location, GLsizei(data.count), &locations)
    }
    
    public func uniform4uiv(location: Int32, data: [UInt32]){
        var locations = data
        glUniform4uiv(location, GLsizei(data.count), &locations)
    }
    
    public func uniformBlockBinding(program: UInt32, uniformBlockIndex: UInt32, uniformBlockBinding: UInt32){
        glUniformBlockBinding(program, uniformBlockIndex, uniformBlockBinding)
    }
    public func uniformMatrix3x2fv(location: UInt32, transpose: Bool, data: [Float]){
        var value = data
        glUniformMatrix3x2fv(GLint(location), GLsizei(data.count), boolConverter(value: transpose), &value)
    }
    public func uniformMatrix4x2fv(location: UInt32, transpose: Bool, data: [Float]){
        var value = data
        glUniformMatrix4x2fv(GLint(location), GLsizei(data.count), boolConverter(value: transpose), &value)
    }
    
    public func uniformMatrix2x3fv(location: UInt32, transpose: Bool, data: [Float]){
        var value = data
        glUniformMatrix2x3fv(GLint(location), GLsizei(data.count), boolConverter(value: transpose), &value)
    }
    public func uniformMatrix4x3fv(location: UInt32, transpose: Bool, data: [Float]){
        var value = data
        glUniformMatrix4x3fv(GLint(location), GLsizei(data.count), boolConverter(value: transpose), &value)
    }
    
    public func uniformMatrix2x4fv(location: UInt32, transpose: Bool, data: [Float]){
        var value = data
        glUniformMatrix2x4fv(GLint(location), GLsizei(data.count), boolConverter(value: transpose), &value)
    }
    
    public func uniformMatrix3x4fv(location: UInt32, transpose: Bool, data: [Float]){
        var value = data
        glUniformMatrix3x4fv(GLint(location), GLsizei(data.count), boolConverter(value: transpose), &value)
    }
    public func vertexAttribDivisor(index: UInt32, divisor: UInt32){
        glVertexAttribDivisor(index, divisor)
    }
    public func vertexAttribI4i(index: UInt32, v0: Int32, v1: Int32, v2: Int32, v3: Int32){
        glVertexAttribI4i(index, v0, v1, v2, v3)
    }
    
    public func vertexAttribI4ui(index: UInt32, v0: UInt32, v1: UInt32, v2: UInt32, v3: UInt32){
        glVertexAttribI4ui(index, v0, v1, v2, v3)
    }
    
    public func vertexAttribI4iv(index: UInt32, value: [Int32]){
        var v = value
        glVertexAttribI4iv(index, &v)
    }
    
    public func vertexAttribI4uiv(index: UInt32, value: [UInt32]){
        var v = value
        glVertexAttribI4uiv(index, &v)
    }
    
    /* Getting GL parameter information */
    public var READ_BUFFER : Int32 { return GL_READ_BUFFER }

    public var UNPACK_ROW_LENGTH : Int32 { return GL_UNPACK_ROW_LENGTH }

    public var UNPACK_SKIP_ROWS : Int32 { return GL_UNPACK_SKIP_ROWS }

    public var UNPACK_SKIP_PIXELS : Int32 { return GL_UNPACK_SKIP_PIXELS }

    public var PACK_ROW_LENGTH : Int32 { return GL_PACK_ROW_LENGTH }

    public var PACK_SKIP_ROWS : Int32 { return GL_PACK_SKIP_ROWS }

    public var PACK_SKIP_PIXELS : Int32 { return GL_PACK_SKIP_PIXELS }

    public var TEXTURE_BINDING_3D : Int32 { return GL_TEXTURE_BINDING_3D }

    public var UNPACK_SKIP_IMAGES : Int32 { return GL_UNPACK_SKIP_IMAGES }

    public var UNPACK_IMAGE_HEIGHT : Int32 { return GL_UNPACK_IMAGE_HEIGHT }

    public var MAX_3D_TEXTURE_SIZE : Int32 { return GL_MAX_3D_TEXTURE_SIZE }

    public var MAX_ELEMENTS_VERTICES : Int32 { return GL_MAX_ELEMENTS_VERTICES }

    public var MAX_ELEMENTS_INDICES : Int32 { return GL_MAX_ELEMENTS_INDICES }

    public var MAX_TEXTURE_LOD_BIAS : Int32 { return GL_MAX_TEXTURE_LOD_BIAS }

    public var MAX_FRAGMENT_UNIFORM_COMPONENTS : Int32 { return GL_MAX_FRAGMENT_UNIFORM_COMPONENTS }

    public var MAX_VERTEX_UNIFORM_COMPONENTS : Int32 { return GL_MAX_VERTEX_UNIFORM_COMPONENTS }

    public var MAX_ARRAY_TEXTURE_LAYERS : Int32 { return GL_MAX_ARRAY_TEXTURE_LAYERS }

    public var MIN_PROGRAM_TEXEL_OFFSET : Int32 { return GL_MIN_PROGRAM_TEXEL_OFFSET }

    public var MAX_PROGRAM_TEXEL_OFFSET : Int32 { return GL_MAX_PROGRAM_TEXEL_OFFSET }

    public var MAX_VARYING_COMPONENTS : Int32 { return GL_MAX_VARYING_COMPONENTS }

    public var FRAGMENT_SHADER_DERIVATIVE_HINT : Int32 { return GL_FRAGMENT_SHADER_DERIVATIVE_HINT }

    public var RASTERIZER_DISCARD : Int32 { return GL_RASTERIZER_DISCARD }

    public var VERTEX_ARRAY_BINDING : Int32 { return GL_VERTEX_ARRAY_BINDING }

    public var MAX_VERTEX_OUTPUT_COMPONENTS : Int32 { return GL_MAX_VERTEX_OUTPUT_COMPONENTS }

    public var MAX_FRAGMENT_INPUT_COMPONENTS : Int32 { return GL_MAX_FRAGMENT_INPUT_COMPONENTS }

    public var MAX_SERVER_WAIT_TIMEOUT : Int32 { return GL_MAX_SERVER_WAIT_TIMEOUT }

    public var MAX_ELEMENT_INDEX : Int32 { return GL_MAX_ELEMENT_INDEX }
    /* Getting GL parameter information */


    /* Textures */

    public var RED : Int32 { return GL_RED }

    public var RGB8 : Int32 { return GL_RGB8 }

    public var RGBA8 : Int32 { return GL_RGBA8 }

    public var RGB10_A2 : Int32 { return GL_RGB10_A2 }

    public var TEXTURE_3D : Int32 { return GL_TEXTURE_3D }

    public var TEXTURE_WRAP_R : Int32 { return GL_TEXTURE_WRAP_R }

    public var TEXTURE_MIN_LOD : Int32 { return GL_TEXTURE_MIN_LOD }

    public var TEXTURE_MAX_LOD : Int32 { return GL_TEXTURE_MAX_LOD }

    public var TEXTURE_BASE_LEVEL : Int32 { return GL_TEXTURE_BASE_LEVEL }

    public var TEXTURE_MAX_LEVEL : Int32 { return GL_TEXTURE_MAX_LEVEL }

    public var TEXTURE_COMPARE_MODE : Int32 { return GL_TEXTURE_COMPARE_MODE }

    public var TEXTURE_COMPARE_FUNC : Int32 { return GL_TEXTURE_COMPARE_FUNC }

    public var SRGB : Int32 { return GL_SRGB }

    public var SRGB8 : Int32 { return GL_SRGB8 }

    public var SRGB8_ALPHA8 : Int32 { return GL_SRGB8_ALPHA8 }

    public var COMPARE_REF_TO_TEXTURE : Int32 { return GL_COMPARE_REF_TO_TEXTURE }

    public var RGBA32F : Int32 { return GL_RGBA32F }

    public var RGB32F : Int32 { return GL_RGB32F }

    public var RGBA16F : Int32 { return GL_RGBA16F }

    public var RGB16F : Int32 { return GL_RGB16F }

    public var TEXTURE_2D_ARRAY : Int32 { return GL_TEXTURE_2D_ARRAY }

    public var TEXTURE_BINDING_2D_ARRAY : Int32 { return GL_TEXTURE_BINDING_2D_ARRAY }

    public var R11F_G11F_B10F : Int32 { return GL_R11F_G11F_B10F }

    public var RGB9_E5 : Int32 { return GL_RGB9_E5 }

    public var RGBA32UI : Int32 { return GL_RGBA32UI }

    public var RGB32UI : Int32 { return GL_RGB32UI }

    public var RGBA16UI : Int32 { return GL_RGBA16UI }

    public var RGB16UI : Int32 { return GL_RGB16UI }

    public var RGBA8UI : Int32 { return GL_RGBA8UI }

    public var RGB8UI : Int32 { return GL_RGB8UI }

    public var RGBA32I : Int32 { return GL_RGBA32I }

    public var RGB32I : Int32 { return GL_RGB32I }

    public var RGBA16I : Int32 { return GL_RGBA16I }

    public var RGB16I : Int32 { return GL_RGB16I }

    public var RGBA8I : Int32 { return GL_RGBA8I }

    public var RGB8I : Int32 { return GL_RGB8I }

    public var RED_INTEGER : Int32 { return GL_RED_INTEGER }

    public var RGB_INTEGER : Int32 { return GL_RGB_INTEGER }

    public var RGBA_INTEGER : Int32 { return GL_RGBA_INTEGER }

    public var R8 : Int32 { return GL_R8 }

    public var RG8 : Int32 { return GL_RG8 }

    public var R16F : Int32 { return GL_R16F }

    public var R32F : Int32 { return GL_R32F }

    public var RG16F : Int32 { return GL_RG16F }

    public var RG32F : Int32 { return GL_RG32F }

    public var R8I : Int32 { return GL_R8I }

    public var R8UI : Int32 { return GL_R8UI }

    public var R16I : Int32 { return GL_R16I }

    public var R16UI : Int32 { return GL_R16UI }

    public var R32I : Int32 { return GL_R32I }

    public var R32UI : Int32 { return GL_R32UI }

    public var RG8I : Int32 { return GL_RG8I }

    public var RG8UI : Int32 { return GL_RG8UI }

    public var RG16I : Int32 { return GL_RG16I }

    public var RG16UI : Int32 { return GL_RG16UI }

    public var RG32I : Int32 { return GL_RG32I }

    public var RG32UI : Int32 { return GL_RG32UI }

    public var R8_SNORM : Int32 { return GL_R8_SNORM }

    public var RG8_SNORM : Int32 { return GL_RG8_SNORM }

    public var RGB8_SNORM : Int32 { return GL_RGB8_SNORM }

    public var RGBA8_SNORM : Int32 { return GL_RGBA8_SNORM }

    public var RGB10_A2UI : Int32 { return GL_RGB10_A2UI }

    public var TEXTURE_IMMUTABLE_FORMAT : Int32 { return GL_TEXTURE_IMMUTABLE_FORMAT }

    public var TEXTURE_IMMUTABLE_LEVELS : Int32 { return GL_TEXTURE_IMMUTABLE_LEVELS }

    /* Textures */


    /* Pixel types */

    public var UNSIGNED_INT_2_10_10_10_REV : Int32 { return GL_UNSIGNED_INT_2_10_10_10_REV }

    public var UNSIGNED_INT_10F_11F_11F_REV : Int32 { return GL_UNSIGNED_INT_10F_11F_11F_REV }

    public var UNSIGNED_INT_5_9_9_9_REV : Int32 { return GL_UNSIGNED_INT_5_9_9_9_REV }

    public var FLOAT_32_UNSIGNED_INT_24_8_REV : Int32 { return GL_FLOAT_32_UNSIGNED_INT_24_8_REV }

    public var UNSIGNED_INT_24_8 : Int32 { return GL_UNSIGNED_INT_24_8 }

    public var HALF_FLOAT : Int32 { return GL_HALF_FLOAT }

    public var RG : Int32 { return GL_RG }

    public var RG_INTEGER : Int32 { return GL_RG_INTEGER }

    public var INT_2_10_10_10_REV : Int32 { return GL_INT_2_10_10_10_REV }

    /* Pixel types */



    /* Queries */

    public var QUERY_RESULT_AVAILABLE : Int32 { return GL_QUERY_RESULT_AVAILABLE }

    public var QUERY_RESULT : Int32 { return GL_QUERY_RESULT }

    public var CURRENT_QUERY : Int32 { return GL_CURRENT_QUERY }

    public var ANY_SAMPLES_PASSED : Int32 { return GL_ANY_SAMPLES_PASSED }

    public var ANY_SAMPLES_PASSED_CONSERVATIVE : Int32 { return GL_ANY_SAMPLES_PASSED_CONSERVATIVE }

    /* Queries */


    /* Draw buffers */

    public var MAX_DRAW_BUFFERS : Int32 { return GL_MAX_DRAW_BUFFERS }
    public var DRAW_BUFFER0 : Int32 { return GL_DRAW_BUFFER0 }
    public var DRAW_BUFFER1 : Int32 { return GL_DRAW_BUFFER1 }
    public var DRAW_BUFFER2 : Int32 { return GL_DRAW_BUFFER2 }
    public var DRAW_BUFFER3 : Int32 { return GL_DRAW_BUFFER3 }
    public var DRAW_BUFFER4 : Int32 { return GL_DRAW_BUFFER4 }
    public var DRAW_BUFFER5 : Int32 { return GL_DRAW_BUFFER5 }
    public var DRAW_BUFFER6 : Int32 { return GL_DRAW_BUFFER6 }
    public var DRAW_BUFFER7 : Int32 { return GL_DRAW_BUFFER7 }
    public var DRAW_BUFFER8 : Int32 { return GL_DRAW_BUFFER8 }
    public var DRAW_BUFFER9 : Int32 { return GL_DRAW_BUFFER9 }
    public var DRAW_BUFFER10 : Int32 { return GL_DRAW_BUFFER10 }
    public var DRAW_BUFFER11 : Int32 { return GL_DRAW_BUFFER11 }
    public var DRAW_BUFFER12 : Int32 { return GL_DRAW_BUFFER12 }
    public var DRAW_BUFFER13 : Int32 { return GL_DRAW_BUFFER13 }
    public var DRAW_BUFFER14 : Int32 { return GL_DRAW_BUFFER14 }
    public var DRAW_BUFFER15 : Int32 { return GL_DRAW_BUFFER15 }
    public var MAX_COLOR_ATTACHMENTS : Int32 { return GL_MAX_COLOR_ATTACHMENTS }

    public var COLOR_ATTACHMENT1 : Int32 { return GL_COLOR_ATTACHMENT1 }

    public var COLOR_ATTACHMENT2 : Int32 { return GL_COLOR_ATTACHMENT2 }

    public var COLOR_ATTACHMENT3 : Int32 { return GL_COLOR_ATTACHMENT3 }

    public var COLOR_ATTACHMENT4 : Int32 { return GL_COLOR_ATTACHMENT4 }

    public var COLOR_ATTACHMENT5 : Int32 { return GL_COLOR_ATTACHMENT5 }

    public var COLOR_ATTACHMENT6 : Int32 { return GL_COLOR_ATTACHMENT6 }

    public var COLOR_ATTACHMENT7 : Int32 { return GL_COLOR_ATTACHMENT7 }

    public var COLOR_ATTACHMENT8 : Int32 { return GL_COLOR_ATTACHMENT8 }

    public var COLOR_ATTACHMENT9 : Int32 { return GL_COLOR_ATTACHMENT9 }

    public var COLOR_ATTACHMENT10 : Int32 { return GL_COLOR_ATTACHMENT10 }

    public var COLOR_ATTACHMENT11 : Int32 { return GL_COLOR_ATTACHMENT11 }

    public var COLOR_ATTACHMENT12 : Int32 { return GL_COLOR_ATTACHMENT12 }

    public var COLOR_ATTACHMENT13 : Int32 { return GL_COLOR_ATTACHMENT13 }

    public var COLOR_ATTACHMENT14 : Int32 { return GL_COLOR_ATTACHMENT14 }

    public var COLOR_ATTACHMENT15 : Int32 { return GL_COLOR_ATTACHMENT15 }

    /* Draw buffers */

    /* Samplers */

    public var SAMPLER_3D : Int32 { return GL_SAMPLER_3D }

    public var SAMPLER_2D_SHADOW : Int32 { return GL_SAMPLER_2D_SHADOW }

    public var SAMPLER_2D_ARRAY : Int32 { return GL_SAMPLER_2D_ARRAY }

    public var SAMPLER_2D_ARRAY_SHADOW : Int32 { return GL_SAMPLER_2D_ARRAY_SHADOW }

    public var SAMPLER_CUBE_SHADOW : Int32 { return GL_SAMPLER_CUBE_SHADOW }

    public var INT_SAMPLER_2D : Int32 { return GL_INT_SAMPLER_2D }

    public var INT_SAMPLER_3D : Int32 { return GL_INT_SAMPLER_3D }

    public var INT_SAMPLER_CUBE : Int32 { return GL_INT_SAMPLER_CUBE }

    public var INT_SAMPLER_2D_ARRAY : Int32 { return GL_INT_SAMPLER_2D_ARRAY }

    public var UNSIGNED_INT_SAMPLER_2D : Int32 { return GL_UNSIGNED_INT_SAMPLER_2D }

    public var UNSIGNED_INT_SAMPLER_3D : Int32 { return GL_UNSIGNED_INT_SAMPLER_3D }

    public var UNSIGNED_INT_SAMPLER_CUBE : Int32 { return GL_UNSIGNED_INT_SAMPLER_CUBE }

    public var UNSIGNED_INT_SAMPLER_2D_ARRAY : Int32 { return GL_UNSIGNED_INT_SAMPLER_2D_ARRAY }

    public var MAX_SAMPLES : Int32 { return GL_MAX_SAMPLES }

    public var SAMPLER_BINDING : Int32 { return GL_SAMPLER_BINDING }

    /* Samplers */


    /* Buffers */

    public var PIXEL_PACK_BUFFER : Int32 { return GL_PIXEL_PACK_BUFFER }

    public var PIXEL_UNPACK_BUFFER : Int32 { return GL_PIXEL_UNPACK_BUFFER }

    public var PIXEL_PACK_BUFFER_BINDING : Int32 { return GL_PIXEL_PACK_BUFFER_BINDING }

    public var PIXEL_UNPACK_BUFFER_BINDING : Int32 { return GL_PIXEL_UNPACK_BUFFER_BINDING }

    public var COPY_READ_BUFFER : Int32 { return GL_COPY_READ_BUFFER }

    public var COPY_WRITE_BUFFER : Int32 { return GL_COPY_WRITE_BUFFER }

    public var COPY_READ_BUFFER_BINDING : Int32 { return GL_COPY_READ_BUFFER_BINDING }

    public var COPY_WRITE_BUFFER_BINDING : Int32 { return GL_COPY_WRITE_BUFFER_BINDING }

    /* Buffers */


    /* Data types */

    public var FLOAT_MAT2x3 : Int32 { return GL_FLOAT_MAT2x3 }

    public var FLOAT_MAT2x4 : Int32 { return GL_FLOAT_MAT2x4 }

    public var FLOAT_MAT3x2 : Int32 { return GL_FLOAT_MAT3x2 }

    public var FLOAT_MAT3x4 : Int32 { return GL_FLOAT_MAT3x4 }

    public var FLOAT_MAT4x2 : Int32 { return GL_FLOAT_MAT4x2 }

    public var FLOAT_MAT4x3 : Int32 { return GL_FLOAT_MAT4x3 }

    public var UNSIGNED_INT_VEC2 : Int32 { return GL_UNSIGNED_INT_VEC2 }

    public var UNSIGNED_INT_VEC3 : Int32 { return GL_UNSIGNED_INT_VEC3 }
    public var UNSIGNED_INT_VEC4 : Int32 { return GL_UNSIGNED_INT_VEC4 }
    public var UNSIGNED_NORMALIZED : Int32 { return GL_UNSIGNED_NORMALIZED }
    public var SIGNED_NORMALIZED : Int32 { return GL_SIGNED_NORMALIZED }


    /* Data types */

    /* Vertex attributes */
    public var VERTEX_ATTRIB_ARRAY_INTEGER : Int32 { return GL_VERTEX_ATTRIB_ARRAY_INTEGER }

    public var VERTEX_ATTRIB_ARRAY_DIVISOR : Int32 { return GL_VERTEX_ATTRIB_ARRAY_DIVISOR }

    /* Vertex attributes */


    /* Transform feedback */

    public var TRANSFORM_FEEDBACK_BUFFER_MODE : Int32 { return GL_TRANSFORM_FEEDBACK_BUFFER_MODE }
    public var MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS : Int32 { return GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_COMPONENTS }
    public var TRANSFORM_FEEDBACK_VARYINGS : Int32 { return GL_TRANSFORM_FEEDBACK_VARYINGS }

    public var TRANSFORM_FEEDBACK_BUFFER_START : Int32 { return GL_TRANSFORM_FEEDBACK_BUFFER_START }

    public var TRANSFORM_FEEDBACK_BUFFER_SIZE : Int32 { return GL_TRANSFORM_FEEDBACK_BUFFER_SIZE }

    public var TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN : Int32 { return GL_TRANSFORM_FEEDBACK_PRIMITIVES_WRITTEN }

    public var MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS : Int32 { return GL_MAX_TRANSFORM_FEEDBACK_INTERLEAVED_COMPONENTS }

    public var MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS : Int32 { return GL_MAX_TRANSFORM_FEEDBACK_SEPARATE_ATTRIBS }

    public var INTERLEAVED_ATTRIBS : Int32 { return GL_INTERLEAVED_ATTRIBS }

    public var SEPARATE_ATTRIBS : Int32 { return GL_SEPARATE_ATTRIBS }

    public var TRANSFORM_FEEDBACK_BUFFER : Int32 { return GL_TRANSFORM_FEEDBACK_BUFFER }

    public var TRANSFORM_FEEDBACK_BUFFER_BINDING : Int32 { return GL_TRANSFORM_FEEDBACK_BUFFER_BINDING }

    public var TRANSFORM_FEEDBACK : Int32 { return GL_TRANSFORM_FEEDBACK }

    public var TRANSFORM_FEEDBACK_PAUSED : Int32 { return GL_TRANSFORM_FEEDBACK_PAUSED }

    public var TRANSFORM_FEEDBACK_ACTIVE : Int32 { return GL_TRANSFORM_FEEDBACK_ACTIVE }

    public var TRANSFORM_FEEDBACK_BINDING : Int32 { return GL_TRANSFORM_FEEDBACK_BINDING }

    /* Transform feedback */

    /* Framebuffers and renderbuffers */

    public var FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING : Int32 { return GL_FRAMEBUFFER_ATTACHMENT_COLOR_ENCODING }
    public var FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE : Int32 { return GL_FRAMEBUFFER_ATTACHMENT_COMPONENT_TYPE }

    public var FRAMEBUFFER_ATTACHMENT_RED_SIZE : Int32 { return GL_FRAMEBUFFER_ATTACHMENT_RED_SIZE }
    public var FRAMEBUFFER_ATTACHMENT_GREEN_SIZE : Int32 { return GL_FRAMEBUFFER_ATTACHMENT_GREEN_SIZE }
    public var FRAMEBUFFER_ATTACHMENT_BLUE_SIZE : Int32 { return GL_FRAMEBUFFER_ATTACHMENT_BLUE_SIZE }
    public var FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE : Int32 { return GL_FRAMEBUFFER_ATTACHMENT_ALPHA_SIZE }

    public var FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE : Int32 { return GL_FRAMEBUFFER_ATTACHMENT_DEPTH_SIZE }
    public var FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE : Int32 { return GL_FRAMEBUFFER_ATTACHMENT_STENCIL_SIZE }

    public var FRAMEBUFFER_DEFAULT : Int32 { return GL_FRAMEBUFFER_DEFAULT }
    public override var DEPTH_STENCIL_ATTACHMENT : Int32 { return GL_DEPTH_STENCIL_ATTACHMENT }
    public override var DEPTH_STENCIL : Int32 { return GL_DEPTH_STENCIL }
    public var DEPTH24_STENCIL8 : Int32 { return GL_DEPTH24_STENCIL8 }

    public var DRAW_FRAMEBUFFER_BINDING : Int32 { return GL_DRAW_FRAMEBUFFER_BINDING }

    public var READ_FRAMEBUFFER : Int32 { return GL_READ_FRAMEBUFFER }

    public var DRAW_FRAMEBUFFER : Int32 { return GL_DRAW_FRAMEBUFFER }

    public var READ_FRAMEBUFFER_BINDING : Int32 { return GL_READ_FRAMEBUFFER_BINDING }

    public var RENDERBUFFER_SAMPLES : Int32 { return GL_RENDERBUFFER_SAMPLES }

    public var FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER : Int32 { return GL_FRAMEBUFFER_ATTACHMENT_TEXTURE_LAYER }

    public  var FRAMEBUFFER_INCOMPLETE_MULTISAMPLE : Int32 { return GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE }

    /* Framebuffers and renderbuffers */


    /* Uniforms */

    public var UNIFORM_BUFFER : Int32 { return GL_UNIFORM_BUFFER }
    public var UNIFORM_BUFFER_BINDING : Int32 { return GL_UNIFORM_BUFFER_BINDING }

    public var UNIFORM_BUFFER_START : Int32 { return GL_UNIFORM_BUFFER_START }

    public var UNIFORM_BUFFER_SIZE : Int32 { return GL_UNIFORM_BUFFER_SIZE }

    public var MAX_VERTEX_UNIFORM_BLOCKS : Int32 { return GL_MAX_VERTEX_UNIFORM_BLOCKS }

    public var MAX_FRAGMENT_UNIFORM_BLOCKS : Int32 { return GL_MAX_FRAGMENT_UNIFORM_BLOCKS }

    public var MAX_COMBINED_UNIFORM_BLOCKS : Int32 { return GL_MAX_COMBINED_UNIFORM_BLOCKS }

    public var MAX_UNIFORM_BUFFER_BINDINGS : Int32 { return GL_MAX_UNIFORM_BUFFER_BINDINGS }

    public var MAX_UNIFORM_BLOCK_SIZE : Int32 { return GL_MAX_UNIFORM_BLOCK_SIZE }

    public var MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS : Int32 { return GL_MAX_COMBINED_VERTEX_UNIFORM_COMPONENTS }

    public var MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS : Int32 { return GL_MAX_COMBINED_FRAGMENT_UNIFORM_COMPONENTS }

    public var UNIFORM_BUFFER_OFFSET_ALIGNMENT : Int32 { return GL_UNIFORM_BUFFER_OFFSET_ALIGNMENT }

    public var ACTIVE_UNIFORM_BLOCKS : Int32 { return GL_ACTIVE_UNIFORM_BLOCKS }

    public var UNIFORM_TYPE : Int32 { return GL_UNIFORM_TYPE }

    public var UNIFORM_SIZE : Int32 { return GL_UNIFORM_SIZE }

    public var UNIFORM_BLOCK_INDEX : Int32 { return GL_UNIFORM_BLOCK_INDEX }

    public var UNIFORM_OFFSET : Int32 { return GL_UNIFORM_OFFSET }

    public var UNIFORM_ARRAY_STRIDE : Int32 { return GL_UNIFORM_ARRAY_STRIDE }

    public var UNIFORM_MATRIX_STRIDE : Int32 { return GL_UNIFORM_MATRIX_STRIDE }

    public var UNIFORM_IS_ROW_MAJOR : Int32 { return GL_UNIFORM_IS_ROW_MAJOR }

    public var UNIFORM_BLOCK_BINDING : Int32 { return GL_UNIFORM_BLOCK_BINDING }

    public var UNIFORM_BLOCK_DATA_SIZE : Int32 { return GL_UNIFORM_BLOCK_DATA_SIZE }

    public var UNIFORM_BLOCK_ACTIVE_UNIFORMS : Int32 { return GL_UNIFORM_BLOCK_ACTIVE_UNIFORMS }

    public var UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES : Int32 { return GL_UNIFORM_BLOCK_ACTIVE_UNIFORM_INDICES }

    public var UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER : Int32 { return GL_UNIFORM_BLOCK_REFERENCED_BY_VERTEX_SHADER }

    public var UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER : Int32 { return GL_UNIFORM_BLOCK_REFERENCED_BY_FRAGMENT_SHADER }


    /* Uniforms */

    /* Sync objects */

    public var OBJECT_TYPE : Int32 { return GL_OBJECT_TYPE }

    public var SYNC_CONDITION : Int32 { return GL_SYNC_CONDITION }

    public var SYNC_STATUS : Int32 { return GL_SYNC_STATUS }

    public var SYNC_FLAGS : Int32 { return GL_SYNC_FLAGS }

    public var SYNC_FENCE : Int32 { return GL_SYNC_FENCE }

    public var SYNC_GPU_COMMANDS_COMPLETE : Int32 { return GL_SYNC_GPU_COMMANDS_COMPLETE }

    public var UNSIGNALED : Int32 { return GL_UNSIGNALED }

    public var SIGNALED : Int32 { return GL_SIGNALED }

    public var ALREADY_SIGNALED : Int32 { return GL_ALREADY_SIGNALED }

    public var TIMEOUT_EXPIRED : Int32 { return GL_TIMEOUT_EXPIRED }


    public var CONDITION_SATISFIED : Int32 { return GL_CONDITION_SATISFIED }

    public var WAIT_FAILED : Int32 { return GL_WAIT_FAILED }

    public var SYNC_FLUSH_COMMANDS_BIT : Int32 { return GL_SYNC_FLUSH_COMMANDS_BIT }

    /* Sync objects */

    /* Miscellaneous constants */

    public var COLOR : Int32 { return GL_COLOR }

    public var DEPTH : Int32 { return GL_DEPTH }

    public var STENCIL : Int32 { return GL_STENCIL }

    public var MIN : Int32 { return GL_MIN }

    public var MAX : Int32 { return GL_MAX }

    public var DEPTH_COMPONENT24 : Int32 { return GL_DEPTH_COMPONENT24 }

    public var STREAM_READ : Int32 { return GL_STREAM_READ }

    public var STREAM_COPY : Int32 { return GL_STREAM_COPY }

    public var STATIC_READ : Int32 { return GL_STATIC_READ }

    public var STATIC_COPY : Int32 { return GL_STATIC_COPY }

    public var DYNAMIC_READ : Int32 { return GL_DYNAMIC_READ }

    public var DYNAMIC_COPY : Int32 { return GL_DYNAMIC_COPY }

    public var DEPTH_COMPONENT32F : Int32 { return GL_DEPTH_COMPONENT32F }

    public var DEPTH32F_STENCIL8 : Int32 { return GL_DEPTH32F_STENCIL8 }

    public var INVALID_INDEX : Int32 { return Int32(GL_INVALID_INDEX) }

    public var TIMEOUT_IGNORED : Int64 { return Int64(GL_TIMEOUT_IGNORED) }

    public var MAX_CLIENT_WAIT_TIMEOUT_WEBGL: Int32 { return 0x9247 }

    /* Miscellaneous constants */
}

