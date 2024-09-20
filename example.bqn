f←•Import "fenster.bqn"

size←500

w←f.OpenWindow size‿size‿"bqn-fenster example"

Rainbow←{𝕊x‿y‿t:
  x‿y↩x‿y÷size
  t↩(100|t)÷100
  h←(x+y)÷2
  f.HSVtoRGB⟨360×h,1,1⟩
}

Rainbow f._render w

•Delay 3

f.CloseWindow w
