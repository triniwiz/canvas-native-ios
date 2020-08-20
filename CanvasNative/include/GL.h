//
//  GL.h
//  Pods
//
//  Created by Osei Fortune on 20/07/2020.
//

#ifndef GL_h
#define GL_h
#import "canvas_native.h"
NSObject* native_gl_get_parameter(GLuint pname);
NSObject* native_gl_get_program_parameter(GLuint program, GLuint pname);
NSObject* native_gl_get_shader_parameter(GLuint shader, GLuint pname);
NSObject* native_gl_get_uniform(GLuint program,GLint location);
NSObject* native_gl_get_vertex_attrib(GLuint index, GLuint pname);

#endif /* GL_h */
