CFLAGS ?= -Wall -Wextra -std=c99 -O2

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
	LDFLAGS = -framework Cocoa -dynamiclib
else
	LDFLAGS = -lX11 -shared
endif

lib.so: lib.c fenster/fenster.h
	$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@

.PHONY: clean
clean:
	rm -f lib.so
