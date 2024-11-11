f←•Import"fenster.bqn"

size←500

Rainbow←{𝕊x‿y:
  x‿y↩x‿y÷size
  h←(x+y)÷2
  f.HSVtoRGB⟨360×h,1,1⟩
}

Rainbow f._display size‿size
