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

void fenster_set_array(struct fenster *f, int start_i, int start_j,
                       int bufwidth, int bufheight,
                       uint32_t buf[bufwidth * bufheight]) {
  int max_i = start_i + bufwidth < f->width ? bufwidth : f->width - start_i;
  int max_j = start_j + bufheight < f->height ? bufheight : f->height - start_j;
  for (int i = 0; i < max_i; i++) {
    for (int j = 0; j < max_j; j++) {
      fenster_pixel(f, start_i + i, start_j + j) = buf[j * bufwidth + i];
    }
  }
  fenster_loop(f);
}
