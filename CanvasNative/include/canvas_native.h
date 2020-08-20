#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

#define WEBGL_BROWSER_DEFAULT_WEBGL 37444

#define WEBGL_UNPACK_COLORSPACE_CONVERSION_WEBGL 37443

#define WEBGL_UNPACK_FLIP_Y_WEBGL 37440

#define WEBGL_UNPACK_PREMULTIPLY_ALPHA_WEBGL 37441

typedef uint32_t GLuint;

typedef float GLfloat;

typedef uint32_t GLenum;

typedef uint32_t GLbitfield;

typedef float GLclampf;

typedef int32_t GLint;

typedef uint8_t GLboolean;

typedef int32_t GLsizei;

typedef struct {
  const char *name;
  GLint size;
  GLuint info_type;
} NativeWebGLActiveInfo;

typedef struct {
  const uint32_t *array;
  size_t length;
} NativeU32Array;

typedef enum {
  I8,
  U8,
  I16,
  U16,
  I32,
  U32,
  F32,
  F64,
  Bool,
  String,
  Null,
  I8Array,
  U8Array,
  I16Array,
  U16Array,
  I32Array,
  U32Array,
  F32Array,
  F64Array,
  BoolArray,
  StringArray,
} NativeAnyValue_Tag;

typedef struct {
  int8_t _0;
} I8_Body;

typedef struct {
  uint8_t _0;
} U8_Body;

typedef struct {
  int16_t _0;
} I16_Body;

typedef struct {
  uint16_t _0;
} U16_Body;

typedef struct {
  int32_t _0;
} I32_Body;

typedef struct {
  uint32_t _0;
} U32_Body;

typedef struct {
  float _0;
} F32_Body;

typedef struct {
  double _0;
} F64_Body;

typedef struct {
  uint8_t _0;
} Bool_Body;

typedef struct {
  const char *_0;
} String_Body;

typedef struct {
  const int8_t *_0;
  uintptr_t _1;
} I8Array_Body;

typedef struct {
  const uint8_t *_0;
  uintptr_t _1;
} U8Array_Body;

typedef struct {
  const int16_t *_0;
  uintptr_t _1;
} I16Array_Body;

typedef struct {
  const uint16_t *_0;
  uintptr_t _1;
} U16Array_Body;

typedef struct {
  const int32_t *_0;
  uintptr_t _1;
} I32Array_Body;

typedef struct {
  const uint32_t *_0;
  uintptr_t _1;
} U32Array_Body;

typedef struct {
  const float *_0;
  uintptr_t _1;
} F32Array_Body;

typedef struct {
  const double *_0;
  uintptr_t _1;
} F64Array_Body;

typedef struct {
  const uint8_t *_0;
  uintptr_t _1;
} BoolArray_Body;

typedef struct {
  const char *_0;
  uintptr_t _1;
} StringArray_Body;

typedef struct {
  NativeAnyValue_Tag tag;
  union {
    I8_Body i8;
    U8_Body u8;
    I16_Body i16;
    U16_Body u16;
    I32_Body i32;
    U32_Body u32;
    F32_Body f32;
    F64_Body f64;
    Bool_Body bool_;
    String_Body string;
    I8Array_Body i8_array;
    U8Array_Body u8_array;
    I16Array_Body i16_array;
    U16Array_Body u16_array;
    I32Array_Body i32_array;
    U32Array_Body u32_array;
    F32Array_Body f32_array;
    F64Array_Body f64_array;
    BoolArray_Body bool_array;
    StringArray_Body string_array;
  };
} NativeAnyValue;

typedef struct {
  const char *name;
  NativeAnyValue value;
} NativeAnyItem;

typedef struct {
  const NativeAnyItem *array;
  size_t length;
} NativeAnyItemArray;

typedef struct {
  GLboolean is_texture;
  GLboolean is_renderbuffer;
  GLint value;
} NativeFramebufferAttachmentParameter;

typedef struct {
  int32_t range_min;
  int32_t range_max;
  int32_t precision;
} NativeWebGLShaderPrecisionFormat;

typedef char GLchar;

typedef uint16_t GLushort;

typedef uint8_t GLubyte;

typedef struct {
  const void *array;
  size_t length;
} CanvasArray;

typedef struct {
  float width;
} CanvasTextMetrics;

typedef struct {
  uint8_t *array;
  size_t length;
} NativeByteArray;

typedef struct {
  const void *device;
  const void *queue;
  const void *drawable;
} CanvasDevice;

void gl_active_texture(GLuint texture);

void gl_attach_shader(GLuint program, GLuint shader);

void gl_begin_query(GLuint target, GLuint query);

void gl_bind_attrib_location(GLuint program, GLuint index, const char *name);

void gl_bind_buffer(GLuint target, GLuint buffer);

void gl_bind_framebuffer(GLuint target, GLuint framebuffer);

void gl_bind_renderbuffer(GLuint target, GLuint renderbuffer);

void gl_bind_texture(GLuint target, GLuint texture);

void gl_blend_color(GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);

void gl_blend_equation(GLuint mode);

void gl_blend_equation_separate(GLuint mode_rgb, GLuint mode_alpha);

void gl_blend_func(GLuint sfactor, GLuint dfactor);

void gl_blend_func_separate(GLuint src_rgb, GLuint dst_rgb, GLuint src_alpha, GLuint dst_alpha);

void gl_buffer_data(GLuint target, intptr_t size, const void *data, GLuint usage);

void gl_buffer_data_f32(GLuint target, const GLfloat *data, intptr_t size, GLuint usage);

void gl_buffer_data_f64(GLuint target, const double *data, intptr_t size, GLuint usage);

void gl_buffer_data_i16(GLuint target, const int16_t *data, intptr_t size, GLuint usage);

void gl_buffer_data_i32(GLuint target, const int32_t *data, intptr_t size, GLuint usage);

void gl_buffer_data_i8(GLuint target, const int8_t *data, intptr_t size, GLuint usage);

void gl_buffer_data_no_data(GLuint target, const void *src_data, GLuint usage);

void gl_buffer_data_u16(GLuint target, const uint16_t *data, intptr_t size, GLuint usage);

void gl_buffer_data_u32(GLuint target, const GLuint *data, intptr_t size, GLuint usage);

void gl_buffer_data_u8(GLuint target, const uint8_t *data, intptr_t size, GLuint usage);

void gl_buffer_sub_data(GLuint target, uintptr_t offset, const void *src_data, uintptr_t size);

void gl_buffer_sub_data_f32(GLuint target,
                            uintptr_t offset,
                            const GLfloat *src_data,
                            uintptr_t size);

void gl_buffer_sub_data_f64(GLuint target,
                            uintptr_t offset,
                            const double *src_data,
                            uintptr_t size);

void gl_buffer_sub_data_i16(GLuint target,
                            uintptr_t offset,
                            const int16_t *src_data,
                            uintptr_t size);

void gl_buffer_sub_data_i32(GLuint target,
                            uintptr_t offset,
                            const int32_t *src_data,
                            uintptr_t size);

void gl_buffer_sub_data_i8(GLuint target, uintptr_t offset, const int8_t *src_data, uintptr_t size);

void gl_buffer_sub_data_u16(GLuint target,
                            uintptr_t offset,
                            const uint16_t *src_data,
                            uintptr_t size);

void gl_buffer_sub_data_u32(GLuint target,
                            uintptr_t offset,
                            const GLuint *src_data,
                            uintptr_t size);

void gl_buffer_sub_data_u8(GLuint target,
                           uintptr_t offset,
                           const uint8_t *src_data,
                           uintptr_t size);

GLenum gl_check_framebuffer_status(GLenum target);

void gl_clear(GLbitfield mask);

void gl_clear_color(GLfloat red, GLfloat green, GLfloat blue, GLfloat alpha);

void gl_clear_depth(GLclampf depth);

void gl_clear_stencil(GLint stencil);

void gl_color_mask(GLboolean red, GLboolean green, GLboolean blue, GLboolean alpha);

void gl_commit(void);

void gl_compile_shader(GLuint shader);

void gl_compressed_tex_image2d(GLuint target,
                               GLint level,
                               GLuint internalformat,
                               GLint width,
                               GLint height,
                               GLint border);

void gl_compressed_tex_image2d_f32(GLuint target,
                                   GLint level,
                                   GLuint internalformat,
                                   GLint width,
                                   GLint height,
                                   GLint border,
                                   const GLfloat *pixels,
                                   int32_t size);

void gl_compressed_tex_image2d_f64(GLuint target,
                                   GLint level,
                                   GLuint internalformat,
                                   GLint width,
                                   GLint height,
                                   GLint border,
                                   const double *pixels,
                                   int32_t size);

void gl_compressed_tex_image2d_i16(GLuint target,
                                   GLint level,
                                   GLuint internalformat,
                                   GLint width,
                                   GLint height,
                                   GLint border,
                                   const int16_t *pixels,
                                   int32_t size);

void gl_compressed_tex_image2d_i32(GLuint target,
                                   GLint level,
                                   GLuint internalformat,
                                   GLint width,
                                   GLint height,
                                   GLint border,
                                   const GLint *pixels,
                                   int32_t size);

void gl_compressed_tex_image2d_i8(GLuint target,
                                  GLint level,
                                  GLuint internalformat,
                                  GLint width,
                                  GLint height,
                                  GLint border,
                                  const int8_t *pixels,
                                  int32_t size);

void gl_compressed_tex_image2d_u16(GLuint target,
                                   GLint level,
                                   GLuint internalformat,
                                   GLint width,
                                   GLint height,
                                   GLint border,
                                   const uint16_t *pixels,
                                   int32_t size);

void gl_compressed_tex_image2d_u32(GLuint target,
                                   GLint level,
                                   GLuint internalformat,
                                   GLint width,
                                   GLint height,
                                   GLint border,
                                   const GLuint *pixels,
                                   int32_t size);

void gl_compressed_tex_image2d_u8(GLuint target,
                                  GLint level,
                                  GLuint internalformat,
                                  GLint width,
                                  GLint height,
                                  GLint border,
                                  const uint8_t *pixels,
                                  int32_t size);

void gl_compressed_tex_sub_image_2d(GLuint target,
                                    GLint level,
                                    GLint xoffset,
                                    GLint yoffset,
                                    GLint width,
                                    GLint height,
                                    GLuint format);

void gl_compressed_tex_sub_image_2d_f64(GLuint target,
                                        GLint level,
                                        GLint xoffset,
                                        GLint yoffset,
                                        GLint width,
                                        GLint height,
                                        GLuint format,
                                        const double *pixels,
                                        int32_t size);

void gl_compressed_tex_sub_image_2d_i16(GLuint target,
                                        GLint level,
                                        GLint xoffset,
                                        GLint yoffset,
                                        GLint width,
                                        GLint height,
                                        GLuint format,
                                        const int16_t *pixels,
                                        int32_t size);

void gl_compressed_tex_sub_image_2d_i32(GLuint target,
                                        GLint level,
                                        GLint xoffset,
                                        GLint yoffset,
                                        GLint width,
                                        GLint height,
                                        GLuint format,
                                        const int32_t *pixels,
                                        int32_t size);

void gl_compressed_tex_sub_image_2d_i8(GLuint target,
                                       GLint level,
                                       GLint xoffset,
                                       GLint yoffset,
                                       GLint width,
                                       GLint height,
                                       GLuint format,
                                       const int8_t *pixels,
                                       int32_t size);

void gl_compressed_tex_sub_image_2d_u16(GLuint target,
                                        GLint level,
                                        GLint xoffset,
                                        GLint yoffset,
                                        GLint width,
                                        GLint height,
                                        GLuint format,
                                        const uint16_t *pixels,
                                        int32_t size);

void gl_compressed_tex_sub_image_2d_u32(GLuint target,
                                        GLint level,
                                        GLint xoffset,
                                        GLint yoffset,
                                        GLint width,
                                        GLint height,
                                        GLuint format,
                                        const GLuint *pixels,
                                        int32_t size);

void gl_compressed_tex_sub_image_2d_u8(GLuint target,
                                       GLint level,
                                       GLint xoffset,
                                       GLint yoffset,
                                       GLint width,
                                       GLint height,
                                       GLuint format,
                                       const uint8_t *pixels,
                                       int32_t size);

void gl_compressed_tex_sub_image_2df32(GLuint target,
                                       GLint level,
                                       GLint xoffset,
                                       GLint yoffset,
                                       GLint width,
                                       GLint height,
                                       GLuint format,
                                       const GLfloat *pixels,
                                       int32_t size);

void gl_copy_tex_image2d(GLuint target,
                         GLint level,
                         GLuint internalformat,
                         GLint x,
                         GLint y,
                         GLint width,
                         GLint height,
                         GLint border);

void gl_copy_tex_sub_image2d(GLuint target,
                             GLint level,
                             GLint xoffset,
                             GLint yoffset,
                             GLint x,
                             GLint y,
                             GLint width,
                             GLint height);

GLuint gl_create_buffer(void);

GLuint gl_create_framebuffer(void);

GLuint gl_create_program(void);

GLuint gl_create_renderbuffer(void);

GLuint gl_create_shader(GLuint shader_type);

GLuint gl_create_texture(void);

void gl_cull_face(GLuint mode);

void gl_delete_buffer(GLuint buffer);

void gl_delete_framebuffer(GLuint frame_buffer);

void gl_delete_program(GLuint program);

void gl_delete_renderbuffer(GLuint render_buffer);

void gl_delete_shader(GLuint shader);

void gl_delete_texture(GLuint texture);

void gl_depth_func(GLuint func);

void gl_depth_mask(GLboolean flag);

void gl_depth_range(GLfloat z_near, GLfloat z_far);

void gl_detach_shader(GLuint program, GLuint shader);

void gl_disable(GLuint cap);

void gl_disable_vertex_attrib_array(GLuint index);

void gl_draw_arrays(GLuint mode, GLint first, GLsizei count);

void gl_draw_elements(GLuint mode, GLint count, GLuint element_type, intptr_t offset);

void gl_enable(GLuint cap);

void gl_enable_vertex_attrib_array(GLuint index);

void gl_finish(void);

void gl_flush(void);

void gl_framebuffer_renderbuffer(GLuint target,
                                 GLuint attachment,
                                 GLuint renderbuffertarget,
                                 GLuint renderbuffer);

void gl_framebuffer_texture2d(GLuint target,
                              GLuint attachment,
                              GLuint textarget,
                              GLuint texture,
                              GLint level);

void gl_front_face(GLuint mode);

void gl_generate_mipmap(GLuint target);

const NativeWebGLActiveInfo *gl_get_active_attrib(GLuint program, GLuint index);

const NativeWebGLActiveInfo *gl_get_active_uniform(GLuint program, GLuint index);

NativeU32Array gl_get_attached_shaders(GLuint program);

GLint gl_get_attrib_location(GLuint program, const char *name);

GLint gl_get_buffer_parameter(GLuint target, GLuint pname);

NativeAnyItemArray *gl_get_context_attributes(void);

GLuint gl_get_error(void);

const NativeFramebufferAttachmentParameter *gl_get_framebuffer_attachment_parameter(GLuint target,
                                                                                    GLuint attachment,
                                                                                    GLuint pname);

NativeAnyValue gl_get_parameter(GLuint pname);

const char *gl_get_program_info_log(GLuint program);

NativeAnyValue gl_get_program_parameter(GLuint program, GLuint pname);

GLint gl_get_renderbuffer_parameter(GLenum target, GLenum pname);

const int8_t *gl_get_shader_info_log(GLuint shader);

NativeAnyValue gl_get_shader_parameter(GLuint shader, GLuint pname);

const NativeWebGLShaderPrecisionFormat *gl_get_shader_precision_format(GLuint shader_type,
                                                                       GLuint precision_type);

const char *gl_get_shader_source(GLuint shader);

GLint gl_get_tex_parameter(GLuint target, GLuint pname);

NativeAnyValue gl_get_uniform(GLuint program, GLint location);

GLint gl_get_uniform_location(GLuint program, const GLchar *name);

NativeAnyValue gl_get_vertex_attrib(GLuint index, GLuint pname);

size_t gl_get_vertex_attrib_offset(GLuint index, GLenum pname);

void gl_hint(GLenum target, GLenum mode);

GLboolean gl_is_buffer(GLuint buffer);

GLboolean gl_is_enabled(GLenum cap);

GLboolean gl_is_framebuffer(GLuint framebuffer);

GLboolean gl_is_program(GLuint program);

GLboolean gl_is_renderbuffer(GLuint renderbuffer);

GLboolean gl_is_shader(GLuint shader);

GLboolean gl_is_texture(GLuint texture);

void gl_line_width(GLfloat width);

void gl_link_program(GLuint program);

void gl_pixel_storei(GLenum pname, GLint param);

void gl_polygon_offset(GLfloat factor, GLfloat units);

void gl_read_pixels_f32(GLint x,
                        GLint y,
                        GLint width,
                        GLint height,
                        GLenum format,
                        GLenum pixel_type,
                        GLfloat *pixels);

void gl_read_pixels_u16(GLint x,
                        GLint y,
                        GLint width,
                        GLint height,
                        GLenum format,
                        GLenum pixel_type,
                        GLushort *pixels);

void gl_read_pixels_u8(GLint x,
                       GLint y,
                       GLint width,
                       GLint height,
                       GLenum format,
                       GLenum pixel_type,
                       GLubyte *pixels);

void gl_renderbuffer_storage(GLenum target, GLenum internal_format, GLint width, GLint height);

void gl_sample_coverage(GLfloat value, GLboolean invert);

void gl_scissor(GLint x, GLint y, GLint width, GLint height);

void gl_shader_source(GLuint shader, const GLchar *source);

void gl_stencil_func(GLenum func, GLint reference, GLuint mask);

void gl_stencil_func_separate(GLenum face, GLenum func, GLint reference, GLuint mask);

void gl_stencil_mask(GLuint mask);

void gl_stencil_mask_separate(GLenum face, GLuint mask);

void gl_stencil_op(GLenum fail, GLenum zfail, GLenum zpass);

void gl_stencil_op_separate(GLenum face, GLenum fail, GLenum zfail, GLenum zpass);

void gl_tex_image_2d(GLenum target,
                     GLint level,
                     GLint internalformat,
                     GLint width,
                     GLint height,
                     GLint border,
                     GLenum format,
                     GLenum image_type);

void gl_tex_image_2d_f32(GLenum target,
                         GLint level,
                         GLint internalformat,
                         GLint width,
                         GLint height,
                         GLint border,
                         GLenum format,
                         GLenum image_type,
                         const GLfloat *pixels);

void gl_tex_image_2d_u16(GLenum target,
                         GLint level,
                         GLint internalformat,
                         GLint width,
                         GLint height,
                         GLint border,
                         GLenum format,
                         GLenum image_type,
                         const GLushort *pixels);

void gl_tex_image_2d_u32(GLenum target,
                         GLint level,
                         GLint internalformat,
                         GLint width,
                         GLint height,
                         GLint border,
                         GLenum format,
                         GLenum image_type,
                         const GLuint *pixels);

void gl_tex_image_2d_u8(GLenum target,
                        GLint level,
                        GLint internalformat,
                        GLint width,
                        GLint height,
                        GLint border,
                        GLenum format,
                        GLenum image_type,
                        const GLubyte *pixels);

void gl_tex_parameterf(GLenum target, GLenum pname, GLfloat param);

void gl_tex_parameteri(GLenum target, GLenum pname, GLint param);

void gl_tex_sub_image_2d(GLenum target,
                         GLint level,
                         GLint xoffset,
                         GLint yoffset,
                         GLint width,
                         GLint height,
                         GLenum format,
                         GLenum image_type);

void gl_tex_sub_image_2d_f32(GLenum target,
                             GLint level,
                             GLint xoffset,
                             GLint yoffset,
                             GLint width,
                             GLint height,
                             GLenum format,
                             GLenum image_type,
                             const GLfloat *pixels);

void gl_tex_sub_image_2d_none(GLenum target,
                              GLint level,
                              GLint xoffset,
                              GLint yoffset,
                              GLenum format,
                              GLenum image_type);

void gl_tex_sub_image_2d_u16(GLenum target,
                             GLint level,
                             GLint xoffset,
                             GLint yoffset,
                             GLint width,
                             GLint height,
                             GLenum format,
                             GLenum image_type,
                             const GLushort *pixels);

void gl_tex_sub_image_2d_u8(GLenum target,
                            GLint level,
                            GLint xoffset,
                            GLint yoffset,
                            GLint width,
                            GLint height,
                            GLenum format,
                            GLenum image_type,
                            const GLubyte *pixels);

void gl_uniform1f(GLint location, GLfloat v0);

void gl_uniform1fv(GLint location, const GLfloat *v0);

void gl_uniform1i(GLint location, GLint v0);

void gl_uniform1iv(GLint location, const GLint *v0);

void gl_uniform2f(GLint location, GLfloat v0, GLfloat v1);

void gl_uniform2fv(GLint location, const GLfloat *v0);

void gl_uniform2i(GLint location, GLint v0, GLint v1);

void gl_uniform2iv(GLint location, const GLint *v0);

void gl_uniform3f(GLint location, GLfloat v0, GLfloat v1, GLfloat v2);

void gl_uniform3fv(GLint location, const GLfloat *v0);

void gl_uniform3i(GLint location, GLint v0, GLint v1, GLint v2);

void gl_uniform3iv(GLint location, const GLint *v0);

void gl_uniform4f(GLint location, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);

void gl_uniform4fv(GLint location, const GLfloat *v0);

void gl_uniform4i(GLint location, GLint v0, GLint v1, GLint v2, GLint v3);

void gl_uniform4iv(GLint location, const GLint *v0);

void gl_uniform_matrix2fv(int32_t location, uint8_t transpose, const GLfloat *value);

void gl_uniform_matrix3fv(int32_t location, uint8_t transpose, const GLfloat *value);

void gl_uniform_matrix4fv(int32_t location, uint8_t transpose, const GLfloat *value);

void gl_use_program(GLuint program);

void gl_validate_program(GLuint program);

void gl_vertex_attrib1f(GLuint index, GLfloat v0);

void gl_vertex_attrib1fv(GLuint index, const GLfloat *value);

void gl_vertex_attrib2f(GLuint index, GLfloat v0, GLfloat v1);

void gl_vertex_attrib2fv(GLuint index, const GLfloat *value);

void gl_vertex_attrib3f(GLuint index, GLfloat v0, GLfloat v1, GLfloat v2);

void gl_vertex_attrib3fv(GLuint index, const GLfloat *value);

void gl_vertex_attrib4f(GLuint index, GLfloat v0, GLfloat v1, GLfloat v2, GLfloat v3);

void gl_vertex_attrib4fv(GLuint index, const GLfloat *value);

void gl_vertex_attrib_pointer(GLuint index,
                              int32_t size,
                              GLuint d_type,
                              uint8_t normalized,
                              int32_t stride,
                              const void *offset);

void gl_viewport(int32_t x, int32_t y, int32_t width, int32_t height);

long long native_arc(long long canvas_native_ptr,
                     float x,
                     float y,
                     float radius,
                     float start_angle,
                     float end_angle,
                     bool anticlockwise);

long long native_arc_to(long long canvas_native_ptr,
                        float x1,
                        float y1,
                        float x2,
                        float y2,
                        float radius);

long long native_begin_path(long long canvas_native_ptr);

long long native_bezier_curve_to(long long canvas_native_ptr,
                                 float cp1x,
                                 float cp1y,
                                 float cp2x,
                                 float cp2y,
                                 float x,
                                 float y);

long long native_clear_canvas(long long canvas_native_ptr, void *view);

long long native_clear_rect(long long canvas_native_ptr,
                            float x,
                            float y,
                            float width,
                            float height,
                            void *view);

long long native_clip(long long canvas_native_ptr, void *view);

long long native_clip_path_rule(long long canvas_native_ptr,
                                long long path,
                                const char *fill_rule,
                                void *view);

long long native_clip_rule(long long canvas_native_ptr, const char *fill_rule, void *view);

long long native_close_path(long long canvas_native_ptr);

long long native_create_image_asset(void);

CanvasArray native_create_image_data(size_t width, size_t height);

long long native_create_matrix(void);

long long native_create_path_2d(void);

long long native_create_path_2d_from_path_data(const char *data);

long long native_create_path_from_path(long long path);

long long native_create_pattern(uint8_t *image_array,
                                size_t image_size,
                                int original_width,
                                int original_height,
                                const char *repetition);

long long native_create_pattern_encoded(uint8_t *image_array,
                                        size_t image_size,
                                        const char *repetition);

long long native_create_text_decoder(const char *decoding);

long long native_create_text_encoder(const char *encoding);

void native_destroy(long long canvas_ptr);

long long native_draw_image(long long canvas_native_ptr,
                            const uint8_t *image_array,
                            size_t image_size,
                            int original_width,
                            int original_height,
                            float dx,
                            float dy,
                            void *view);

long long native_draw_image_dw(long long canvas_native_ptr,
                               const uint8_t *image_array,
                               size_t image_size,
                               int original_width,
                               int original_height,
                               float dx,
                               float dy,
                               float d_width,
                               float d_height,
                               void *view);

long long native_draw_image_dw_raw(long long canvas_native_ptr,
                                   const uint8_t *image_array,
                                   size_t image_size,
                                   int original_width,
                                   int original_height,
                                   float dx,
                                   float dy,
                                   float d_width,
                                   float d_height,
                                   void *view);

long long native_draw_image_raw(long long canvas_native_ptr,
                                const uint8_t *image_array,
                                size_t image_size,
                                int original_width,
                                int original_height,
                                float dx,
                                float dy,
                                void *view);

long long native_draw_image_sw(long long canvas_native_ptr,
                               const uint8_t *image_array,
                               size_t image_size,
                               int original_width,
                               int original_height,
                               float sx,
                               float sy,
                               float s_width,
                               float s_height,
                               float dx,
                               float dy,
                               float d_width,
                               float d_height,
                               void *view);

long long native_draw_image_sw_raw(long long canvas_native_ptr,
                                   const uint8_t *image_array,
                                   size_t image_size,
                                   int original_width,
                                   int original_height,
                                   float sx,
                                   float sy,
                                   float s_width,
                                   float s_height,
                                   float dx,
                                   float dy,
                                   float d_width,
                                   float d_height,
                                   void *view);

void native_drop_image_data(CanvasArray data);

void native_drop_text_metrics(CanvasTextMetrics data);

long long native_ellipse(long long canvas_native_ptr,
                         float x,
                         float y,
                         float radius_x,
                         float radius_y,
                         float rotation,
                         float start_angle,
                         float end_angle,
                         bool anticlockwise);

long long native_fill(long long canvas_native_ptr, void *view);

long long native_fill_path_rule(long long canvas_native_ptr,
                                long long path_ptr,
                                const char *rule,
                                void *view);

long long native_fill_rect(long long canvas_native_ptr,
                           float x,
                           float y,
                           float width,
                           float height,
                           void *view);

long long native_fill_rule(long long canvas_native_ptr, const char *rule, void *view);

long long native_fill_text(long long canvas_native_ptr,
                           const char *text,
                           float x,
                           float y,
                           float width,
                           void *view);

long long native_flush(long long canvas_ptr);

void native_free_byte_array(NativeByteArray array);

void native_free_char(const char *text);

void native_free_matrix_data(CanvasArray data);

void native_free_path_2d(long long path);

void native_free_pattern(long long pattern);

long long native_get_current_transform(long long canvas_native_ptr);

CanvasArray native_get_image_data(long long canvas_native_ptr,
                                  float sx,
                                  float sy,
                                  size_t sw,
                                  size_t sh);

CanvasDevice native_get_ios_device(long long canvas_native_ptr);

CanvasArray native_get_matrix(long long matrix);

long long native_image_asset_flip_x(long long asset);

void native_image_asset_flip_x_in_place_owned(uint32_t width,
                                              uint32_t height,
                                              uint8_t *buf,
                                              uintptr_t length);

long long native_image_asset_flip_y(long long asset);

void native_image_asset_flip_y_in_place_owned(uint32_t width,
                                              uint32_t height,
                                              uint8_t *buf,
                                              uintptr_t length);

void native_image_asset_free_bytes(NativeByteArray data);

NativeByteArray native_image_asset_get_bytes(long long asset);

const char *native_image_asset_get_error(long long asset);

unsigned int native_image_asset_get_height(long long asset);

unsigned int native_image_asset_get_width(long long asset);

unsigned int native_image_asset_load_from_path(long long asset, const char *path);

unsigned int native_image_asset_load_from_raw(long long asset, const uint8_t *array, size_t size);

void native_image_asset_release(long long asset);

long long native_image_asset_scale(long long asset, unsigned int x, unsigned int y);

long long native_image_smoothing_enabled(long long canvas_native_ptr, bool enabled);

long long native_image_smoothing_quality(long long canvas_native_ptr, const char *quality);

long long native_init(void *device, void *queue, void *view, float scale, const char *direction);

long long native_init_legacy(int width,
                             int height,
                             int buffer_id,
                             float scale,
                             const char *direction);

unsigned char native_is_point_in_path(int64_t canvas_ptr, float x, float y);

unsigned char native_is_point_in_path_with_path_rule(int64_t canvas_ptr,
                                                     int64_t path,
                                                     float x,
                                                     float y,
                                                     const char *fill_rule);

unsigned char native_is_point_in_path_with_rule(int64_t canvas_ptr,
                                                float x,
                                                float y,
                                                const char *fill_rule);

unsigned char native_is_point_in_stroke(int64_t canvas_ptr, float x, float y);

unsigned char native_is_point_in_stroke_with_path(int64_t canvas_ptr,
                                                  int64_t path,
                                                  float x,
                                                  float y);

long long native_line_dash_offset(long long canvas_native_ptr, float offset);

long long native_line_join(long long canvas_native_ptr, const char *line_join);

long long native_line_to(long long canvas_native_ptr, float x, float y);

CanvasTextMetrics native_measure_text(long long canvas_native_ptr, const char *text);

long long native_miter_limit(long long canvas_native_ptr, float limit);

long long native_move_to(long long canvas_native_ptr, float x, float y);

unsigned int native_native_image_asset_save_path(long long asset,
                                                 const char *path,
                                                 unsigned int format);

long long native_path_2d_add_path(long long path, long long path_to_add, long long matrix);

long long native_path_2d_arc(long long path,
                             float x,
                             float y,
                             float radius,
                             float start_angle,
                             float end_angle,
                             bool anticlockwise);

long long native_path_2d_arc_to(long long path,
                                float x1,
                                float y1,
                                float x2,
                                float y2,
                                float radius);

long long native_path_2d_bezier_curve_to(long long path,
                                         float cp1x,
                                         float cp1y,
                                         float cp2x,
                                         float cp2y,
                                         float x,
                                         float y);

long long native_path_2d_close_path(long long path);

long long native_path_2d_ellipse(long long path,
                                 float x,
                                 float y,
                                 float radius_x,
                                 float radius_y,
                                 float rotation,
                                 float start_angle,
                                 float end_angle,
                                 bool anticlockwise);

long long native_path_2d_line_to(long long path, float x, float y);

long long native_path_2d_move_to(long long path, float x, float y);

long long native_path_2d_quadratic_curve_to(long long path, float cpx, float cpy, float x, float y);

long long native_path_2d_rect(long long path, float x, float y, float width, float height);

long long native_put_image_data(long long canvas_native_ptr,
                                size_t width,
                                size_t height,
                                const uint8_t *array,
                                size_t array_size,
                                float x,
                                float y,
                                float dirty_x,
                                float dirty_y,
                                size_t dirty_width,
                                size_t dirty_height);

long long native_quadratic_curve_to(long long canvas_native_ptr,
                                    float cpx,
                                    float cpy,
                                    float x,
                                    float y);

long long native_rect(long long canvas_native_ptr, float x, float y, float width, float height);

long long native_reset_transform(long long canvas_native_ptr);

long long native_restore(long long canvas_native_ptr);

long long native_rotate(long long canvas_native_ptr, float angle, void *view);

long long native_save(long long canvas_native_ptr);

long long native_scale(long long canvas_native_ptr, float x, float y, void *view);

long long native_set_current_transform(long long canvas_native_ptr, long long matrix);

long long native_set_fill_color(long long canvas_native_ptr, uint32_t color);

long long native_set_fill_color_rgba(long long canvas_native_ptr,
                                     uint8_t red,
                                     uint8_t green,
                                     uint8_t blue,
                                     uint8_t alpha);

long long native_set_fill_gradient_linear(long long canvas_native_ptr,
                                          float x0,
                                          float y0,
                                          float x1,
                                          float y1,
                                          size_t colors_size,
                                          const unsigned int *colors_array,
                                          size_t positions_size,
                                          const float *positions_array);

long long native_set_fill_gradient_radial(long long canvas_native_ptr,
                                          float x0,
                                          float y0,
                                          float radius_0,
                                          float x1,
                                          float y1,
                                          float radius_1,
                                          size_t colors_size,
                                          const unsigned int *colors_array,
                                          size_t positions_size,
                                          const float *positions_array);

long long native_set_fill_pattern(long long canvas_native_ptr, long long pattern);

long long native_set_font(long long canvas_native_ptr, const char *font);

long long native_set_global_alpha(long long canvas_native_ptr, uint8_t alpha);

long long native_set_global_composite_operation(long long canvas_native_ptr, const char *composite);

long long native_set_line_cap(long long canvas_native_ptr, const char *line_cap);

long long native_set_line_dash(long long canvas_native_ptr, size_t size, const float *array);

long long native_set_line_width(long long canvas_native_ptr, float line_width);

long long native_set_matrix(long long matrix, const void *array, size_t length);

long long native_set_pattern_transform(long long pattern, long long matrix);

long long native_set_stroke_color(long long canvas_native_ptr, uint32_t color);

long long native_set_stroke_color_rgba(long long canvas_native_ptr,
                                       uint8_t red,
                                       uint8_t green,
                                       uint8_t blue,
                                       uint8_t alpha);

long long native_set_stroke_gradient_linear(long long canvas_native_ptr,
                                            float x0,
                                            float y0,
                                            float x1,
                                            float y1,
                                            size_t colors_size,
                                            const unsigned int *colors_array,
                                            size_t positions_size,
                                            const float *positions_array);

long long native_set_stroke_gradient_radial(long long canvas_native_ptr,
                                            float x0,
                                            float y0,
                                            float radius_0,
                                            float x1,
                                            float y1,
                                            float radius_1,
                                            size_t colors_size,
                                            const unsigned int *colors_array,
                                            size_t positions_size,
                                            const float *positions_array);

long long native_set_stroke_pattern(long long canvas_native_ptr, long long pattern);

long long native_set_transform(long long canvas_native_ptr,
                               float a,
                               float b,
                               float c,
                               float d,
                               float e,
                               float f,
                               void *view);

long long native_shadow_blur(long long canvas_native_ptr, float limit);

long long native_shadow_color(long long canvas_native_ptr, uint32_t color);

long long native_shadow_offset_x(long long canvas_native_ptr, float x);

long long native_shadow_offset_y(long long canvas_native_ptr, float y);

NativeByteArray native_snapshot_canvas(long long canvas_native_ptr);

long long native_stroke(long long canvas_native_ptr, void *view);

long long native_stroke_path(long long canvas_native_ptr, long long path, void *view);

long long native_stroke_rect(long long canvas_native_ptr,
                             float x,
                             float y,
                             float width,
                             float height,
                             void *view);

long long native_stroke_text(long long canvas_native_ptr,
                             const char *text,
                             float x,
                             float y,
                             float width,
                             void *view);

long long native_surface_resized(int _width,
                                 int _height,
                                 void *_device,
                                 void *_queue,
                                 float _scale,
                                 long long current_canvas);

long long native_surface_resized_legacy(int width,
                                        int height,
                                        int buffer_id,
                                        float _scale,
                                        long long canvas_native_ptr);

long long native_text_align(long long canvas_native_ptr, const char *alignment);

const char *native_text_decoder_decode(int64_t decoder, const uint8_t *data, size_t len);

const char *native_text_decoder_decode_i16(int64_t decoder, const int16_t *data, size_t len);

const char *native_text_decoder_decode_i32(int64_t decoder, const int32_t *data, size_t len);

const char *native_text_decoder_decode_u16(int64_t decoder, const uint16_t *data, size_t len);

void native_text_decoder_free(int64_t decoder);

const char *native_text_decoder_get_encoding(int64_t decoder);

NativeByteArray native_text_encoder_encode(int64_t encoder, const char *text);

void native_text_encoder_free(int64_t encoder);

const char *native_text_encoder_get_encoding(int64_t encoder);

char *native_to_data_url(long long canvas_ptr, const char *format, float quality);

long long native_transform(long long canvas_native_ptr,
                           float a,
                           float b,
                           float c,
                           float d,
                           float e,
                           float f,
                           void *_view);

long long native_translate(long long canvas_native_ptr, float x, float y, void *view);
