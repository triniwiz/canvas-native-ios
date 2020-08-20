//
//  GL.m
//  Pods
//
//  Created by Osei Fortune on 20/07/2020.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
//headers.push("OpenGLES/ES3/gl.h");
//headers.push("OpenGLES/ES3/glext.h");
#import <OpenGLES/EAGL.h>
#import "canvas_native.h"

NSObject* handle_any_value(NativeAnyValue value){
    NSMutableArray* array = [NSMutableArray array];
    switch (value.tag) {
        case I8:
            return [NSNumber numberWithChar: value.i8._0];
        case I8Array:
//            return [NSArray arrayWithObjects:(__unsafe_unretained id *)(void *) value.i8_array._0 count: value.i8_array._1];
            for(int i = 0;i < value.i8_array._1;i++){
                           [array addObject: @(value.i8_array._0[i])];
                       }
                      // return [NSArray arrayWithObjects:(__unsafe_unretained id *)(void *) value.i32_array._0 count: value.i32_array._1];
                       return array;
        case U8:
            return [NSNumber numberWithUnsignedChar: value.u8._0];
        case U8Array:
//            return [NSArray arrayWithObjects:(__unsafe_unretained id *)(void *) value.u8_array._0 count: value.u8_array._1];
            for(int i = 0;i < value.u8_array._1;i++){
                           [array addObject: @(value.u8_array._0[i])];
                       }
                      // return [NSArray arrayWithObjects:(__unsafe_unretained id *)(void *) value.i32_array._0 count: value.i32_array._1];
                       return array;
        case I16:
            return [NSNumber numberWithShort: value.i16._0];
        case I16Array:
//            return [NSArray arrayWithObjects:(__unsafe_unretained id *)(void *) value.i16_array._0 count: value.i16_array._1];
            for(int i = 0;i < value.i16_array._1;i++){
                           [array addObject: @(value.i16_array._0[i])];
                       }
                      // return [NSArray arrayWithObjects:(__unsafe_unretained id *)(void *) value.i32_array._0 count: value.i32_array._1];
                       return array;
        case U16:
            return [NSNumber numberWithUnsignedShort: value.u16._0];
        case U16Array:
//            return [NSArray arrayWithObjects:(__unsafe_unretained id *)(void *) value.u16_array._0 count: value.u16_array._1];
            for(int i = 0;i < value.u16_array._1;i++){
                           [array addObject: @(value.u16_array._0[i])];
                       }
                      // return [NSArray arrayWithObjects:(__unsafe_unretained id *)(void *) value.i32_array._0 count: value.i32_array._1];
                       return array;
        case I32:
            return [NSNumber numberWithInt: value.i32._0];
        case I32Array:
            for(int i = 0;i < value.i32_array._1;i++){
                [array addObject: [NSNumber numberWithInt:value.i32_array._0[i] ]];
            }
           // return [NSArray arrayWithObjects:(__unsafe_unretained id *)(void *) value.i32_array._0 count: value.i32_array._1];
            return array;
        case U32:
            return [NSNumber numberWithUnsignedInt: value.u32._0];
        case U32Array:
//            return [NSArray arrayWithObjects: (__unsafe_unretained id *)(void *)value.u32_array._0 count: value.u32_array._1];
            for(int i = 0;i < value.u32_array._1;i++){
                           [array addObject: @(value.u32_array._0[i])];
                       }
                      // return [NSArray arrayWithObjects:(__unsafe_unretained id *)(void *) value.i32_array._0 count: value.i32_array._1];
                       return array;
        case F32:
            return [NSNumber numberWithFloat: value.f32._0];
        case F32Array:
//            return [NSArray arrayWithObjects: (__unsafe_unretained id *)(void *)value.f32_array._0 count: value.f32_array._1];
            for(int i = 0;i < value.f32_array._1;i++){
                           [array addObject: @(value.f32_array._0[i])];
                       }
                      // return [NSArray arrayWithObjects:(__unsafe_unretained id *)(void *) value.i32_array._0 count: value.i32_array._1];
                       return array;
        case F64:
            return [NSNumber numberWithDouble: value.f64._0];
        case F64Array:
//            return [NSArray arrayWithObjects: (__unsafe_unretained id *)(void *)value.f64_array._0 count: value.f64_array._1];
            for(int i = 0;i < value.f64_array._1;i++){
                           [array addObject: @(value.f64_array._0[i])];
                       }
                      // return [NSArray arrayWithObjects:(__unsafe_unretained id *)(void *) value.i32_array._0 count: value.i32_array._1];
                       return array;
        case Bool:
            return [NSNumber numberWithBool:value.bool_._0 == 1];
        case BoolArray:
//            return [NSArray arrayWithObjects:(__unsafe_unretained id *)(void *) value.bool_array._0 count:value.bool_array._1];
            for(int i = 0;i < value.bool_array._1;i++){
                [array addObject: [NSNumber numberWithBool: value.bool_array._0[i] == 1] ];
                       }
                      // return [NSArray arrayWithObjects:(__unsafe_unretained id *)(void *) value.i32_array._0 count: value.i32_array._1];
                       return array;
        case String:
            return [NSString stringWithUTF8String: value.string._0];
        case StringArray:
//            return [NSArray arrayWithObjects: (__unsafe_unretained id *)(void *)value.string_array._0 count: value.string_array._1];
            for(int i = 0;i < value.bool_array._1;i++){
                [array addObject: [NSString stringWithUTF8String: &value.string_array._0[i]] ];
                   }
                  // return [NSArray arrayWithObjects:(__unsafe_unretained id *)(void *) value.i32_array._0 count: value.i32_array._1];
                   return array;
        default:
            return [NSNull null];
    }
}

NSObject* native_gl_get_parameter(GLuint pname){
    return handle_any_value(gl_get_parameter(pname));
}


NSObject* native_gl_get_shader_parameter(GLuint shader, GLuint pname) {
    return handle_any_value(gl_get_shader_parameter(shader, pname));
}

NSObject* native_gl_get_program_parameter(GLuint program, GLuint pname){
    return handle_any_value(gl_get_program_parameter(program, pname));
}

NSObject* native_gl_get_uniform(GLuint program,GLint location){
    return handle_any_value(gl_get_uniform(program, location));
}

NSObject* native_gl_get_vertex_attrib(GLuint index, GLuint pname) {
    return handle_any_value(gl_get_vertex_attrib(index, pname));
}
