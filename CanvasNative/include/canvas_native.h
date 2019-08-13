#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>

#define SK_SCALAR1 1


typedef struct {
  const void *array;
  size_t length;
} CanvasImageData;

typedef struct {
  float width;
} CanvasTextMetrics;

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

long long native_clear_canvas(long long canvas_native_ptr);

long long native_clear_rect(long long canvas_native_ptr,
                            float x,
                            float y,
                            float width,
                            float height);

long long native_clip(long long canvas_native_ptr, const char *fill_rule);

long long native_close_path(long long canvas_native_ptr);

CanvasImageData native_create_image_data(size_t width, size_t height);

long long native_draw_image(long long canvas_native_ptr,
                            uint8_t *image_array,
                            size_t image_size,
                            int original_width,
                            int original_height,
                            float dx,
                            float dy);

long long native_draw_image_dw(long long canvas_native_ptr,
                               uint8_t *image_array,
                               size_t image_size,
                               int original_width,
                               int original_height,
                               float dx,
                               float dy,
                               float d_width,
                               float d_height);

long long native_draw_image_sw(long long canvas_native_ptr,
                               uint8_t *image_array,
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
                               float d_height);

void native_drop_image_data(CanvasImageData data);

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

long long native_fill(long long canvas_native_ptr);

long long native_fill_rect(long long canvas_native_ptr,
                           float x,
                           float y,
                           float width,
                           float height);

long long native_fill_text(long long canvas_native_ptr,
                           const char *text,
                           float x,
                           float y,
                           float width);

CanvasImageData native_get_image_data(long long canvas_native_ptr,
                                      float sx,
                                      float sy,
                                      size_t sw,
                                      size_t sh);

long long native_image_smoothing_enabled(long long canvas_native_ptr, bool enabled);

long long native_image_smoothing_quality(long long canvas_native_ptr, const char *quality);

long long native_init(int width, int height, int buffer_id, float scale);

long long native_line_dash_offset(long long canvas_native_ptr, float offset);

long long native_line_join(long long canvas_native_ptr, const char *line_cap);

long long native_line_to(long long canvas_native_ptr, float x, float y);

CanvasTextMetrics native_measure_text(long long canvas_native_ptr, const char *text);

long long native_miter_limit(long long canvas_native_ptr, float limit);

long long native_move_to(long long canvas_native_ptr, float x, float y);

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

long long native_rotate(long long canvas_native_ptr, float angle);

long long native_save(long long canvas_native_ptr);

long long native_scale(long long canvas_native_ptr, float x, float y);

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
                                          const size_t *colors_array,
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
                                          const size_t *colors_array,
                                          size_t positions_size,
                                          const float *positions_array);

long long native_set_font(long long canvas_native_ptr, const char *font);

long long native_set_global_alpha(long long canvas_native_ptr, uint8_t alpha);

long long native_set_global_composite_operation(long long canvas_native_ptr, const char *composite);

long long native_set_line_cap(long long canvas_native_ptr, const char *line_cap);

long long native_set_line_dash(long long canvas_native_ptr, size_t size, const float *array);

long long native_set_line_width(long long canvas_native_ptr, float line_width);

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
                                            const size_t *colors_array,
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
                                            const size_t *colors_array,
                                            size_t positions_size,
                                            const float *positions_array);

long long native_set_transform(long long canvas_native_ptr,
                               float a,
                               float b,
                               float c,
                               float d,
                               float e,
                               float f);

long long native_shadow_blur(long long canvas_native_ptr, float limit);

long long native_shadow_color(long long canvas_native_ptr, uint32_t color);

long long native_shadow_offset_x(long long canvas_native_ptr, float x);

long long native_shadow_offset_y(long long canvas_native_ptr, float y);

long long native_stroke(long long canvas_native_ptr);

long long native_stroke_rect(long long canvas_native_ptr,
                             float x,
                             float y,
                             float width,
                             float height);

long long native_stroke_text(long long canvas_native_ptr,
                             const char *text,
                             float x,
                             float y,
                             float width);

long long native_surface_resized(int width, int height, int buffer_id, long long current_canvas);

long long native_text_align(long long canvas_native_ptr, const char *alignment);

long long native_transform(long long canvas_native_ptr,
                           float a,
                           float b,
                           float c,
                           float d,
                           float e,
                           float f);

long long native_translate(long long canvas_native_ptr, float x, float y);
