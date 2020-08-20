//
//  Utils.h
//  Pods
//
//  Created by Osei Fortune on 5/1/20.
//

#ifndef Utils_h
#define Utils_h

void flipInPlace(unsigned char* data, int width, int height);
void flipInPlaceRaw(void *data, int width, int height);
void flipInPlace3D(unsigned char *data, int width, int height, int depth);
void flipInPlace3D(unsigned char *data, int width, int height, int depth);
unsigned char* loadImagePath(const char *path, int *width, int *height, int *channels);
unsigned char* loadImageBytes(unsigned char *buffer, int length, int *width, int *height, int *channels);
void free_image(unsigned char* image);
const char* image_load_error();
void offsetU8By(uint8_t *data, int offset);

void offsetI8By(int8_t *data, int offset);

void offsetU16By(uint16_t *data, int offset);

void offsetI16By(int16_t *data, int offset);

void offsetU32By(uint32_t *data, int offset);

void offsetI32By(int32_t *data, int offset);

void offsetF32By(float *data, int offset);

void offsetF64By(double *data, int offset);
#endif /* Utils_h */
