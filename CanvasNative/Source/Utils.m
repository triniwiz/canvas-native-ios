//
//  Utils.m
//  CanvasNative
//
//  Created by Osei Fortune on 5/1/20.
//

#import <Foundation/Foundation.h>
#import "stb_image.h"
void flipInPlace(unsigned char *data, int width, int height){
    size_t line_size = width * 4;
    unsigned char* line_buffer = (unsigned char *) calloc(line_size, sizeof(unsigned char));
    int half_height =  height /2;
    for (int y = 0; y < half_height;){
        void* top_line = data + y * line_size;
        void* bottom_line = data + (height - y -1) * line_size;
        memcpy(line_buffer, top_line, line_size);
        memcpy(top_line, bottom_line, line_size);
        memcpy(bottom_line, line_buffer, line_size);
    }
    free(line_buffer);
}

void flipInPlaceRaw(void *data, int width, int height){
    flipInPlace(data, width, height);
}

void flipInPlace3D(unsigned char *data, int width, int height, int depth){
    int row_size = width * 4;
    unsigned char *texelLayer = data;
    for (int z = 0; z < depth; z++) {
      flipInPlace(texelLayer, row_size, height);
      texelLayer += 4 * width * height;
    }
}

void flipInPlace3DRaw(void *data, int width, int height, int depth){
    flipInPlace3D(data, width, height, depth);
}

unsigned char* loadImagePath(const char *path, int *width, int *height, int *channels){
   // int w;
   // int h;
   // int c;
    //stbi_convert_iphone_png_to_rgb(1);
    stbi_set_unpremultiply_on_load(1);
    return stbi_load(path, width, height, channels, STBI_rgb_alpha);
   // int pixelcount = w * h;
    //NSLog(@"after %@", data[pixelcount]);
   /* for (int pi=0; pi<pixelcount; ++pi)
    {
        unsigned char alpha = data[3];
        if( alpha!=255 && alpha!=0 )
        {
            data[0] = ((int)data[0])*255/alpha;
            data[1] = ((int)data[1])*255/alpha;
            data[2] = ((int)data[2])*255/alpha;
        }
        data += 4;
    }
    *width = w;
    *height = h;
    *channels = c;
    return data;
    */
}

unsigned char* loadImageBytes(unsigned char *buffer, int length, int *width, int *height, int *channels){
    return stbi_load_from_memory(buffer, length, width, height, channels, STBI_rgb_alpha);
}


void free_image(unsigned char* image){
    stbi_image_free(image);
}

const char* image_load_error(){
    return stbi_failure_reason();
}

void offsetU8By(uint8_t *data, int offset){
    data += offset;
}

void offsetI8By(int8_t *data, int offset){
    data += offset;
}

void offsetU16By(uint16_t *data, int offset){
    data += offset;
}

void offsetI16By(int16_t *data, int offset){
    data += offset;
}


void offsetU32By(uint32_t *data, int offset){
    data += offset;
}

void offsetI32By(int32_t *data, int offset){
    data += offset;
}


void offsetF32By(float *data, int offset){
    data += offset;
}

void offsetF64By(double *data, int offset){
    data += offset;
}
