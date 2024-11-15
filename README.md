# Minimal graphical applications in BQN

Bindings for [Fenster](https://github.com/zserge/fenster), providing a
set of functions for displaying a window and setting the color of
individual pixels inside.

## Setup

Clone the repository recursively (`git clone --recurse-submodules`)
and run `make` to build the shared library. The Makefile should work
on Linux and macOS.

## API

High-level API:

- `F _display width‿height` creates a window of the given dimensions
  and displays its left operand. `F` should be a function returning a
  color as an RGB triplet in the (0,1) range, and taking a list of two
  elements `x‿y`, where `x` and `y` are the pixel coordinates.

Low-level API:

- `OpenWindow w‿h‿t` opens a window of width `w` and height `h`, with
  title `t`. Returns a window handle.
- `CloseWindow w` closes a window given its handle `w`.
- `F _render w` runs the function `F` at each coordinate of the window
  `w` and set the corresponding pixel color. `F` is a function with
  the same arguments as for `_display`.

## Example

See [example.bqn](./example.bqn).

```bqn
f←•Import"fenster.bqn"

size←500

Rainbow←{𝕊x‿y:
  x‿y↩x‿y÷size
  h←(x+y)÷2
  f.HSVtoRGB⟨360×h,1,1⟩
}

Rainbow f._display size‿size
```

![img](./example.png)
