//
//  Utils.h
//  Pods
//
//  Created by Osei Fortune on 5/1/20.
//

#ifndef Utils_h
#define Utils_h

void flipInPlace(unsigned char* data, int width, int height);
void flipInPlace3D(unsigned char *data, int width, int height, int depth);
void offsetBy(uint8_t *data, int offset);
unsigned char* loadImagePath(const char *path, int *width, int *height, int *channels);
unsigned char* loadImageBytes(unsigned char *buffer, int length, int *width, int *height, int *channels);
void free_image(unsigned char* image);
const char* image_load_error();
#endif /* Utils_h */
