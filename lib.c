#include "fenster/fenster.h"
#include <stdlib.h>
#include <string.h>

struct fenster *fenster_init(int width, int height, int title_length,
                             char title[title_length]) {
  uint32_t *buf = calloc(width * height, sizeof(uint32_t));
  char *title_init = malloc(title_length);
  memcpy(title_init, title, title_length);
  struct fenster f_init = {
      .title = title_init,
      .width = width,
      .height = height,
      .buf = buf,
  };
  struct fenster *f = malloc(sizeof(struct fenster));
  memcpy(f, &f_init, sizeof(struct fenster));
  return f;
}

int fenster_get_width(struct fenster *f) { return f->width; }

int fenster_get_height(struct fenster *f) { return f->height; }

uint32_t fenster_get_pixel(struct fenster *f, int i, int j) {
  return fenster_pixel(f, i, j);
}

void fenster_set_pixel(struct fenster *f, int i, int j, uint32_t color) {
  fenster_pixel(f, i, j) = color;
}
