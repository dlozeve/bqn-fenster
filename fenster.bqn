⟨
  OpenWindow,
  CloseWindow,
  _render,
  Black,
  White,
  Gray,
  Red,
  Green,
  Blue,
  HSVtoRGB
⟩⇐

FensterFFI←"lib.so"⊸•FFI

fensterOpen←FensterFFI"i8"‿"fenster_open"‿">*:i8"
fensterLoop←FensterFFI"i8"‿"fenster_loop"‿">*:i8"
fensterClose←FensterFFI""‿"fenster_close"‿">*:i8"
fensterSleep←FensterFFI""‿"fenster_sleep"‿">u32"
fensterTime←FensterFFI"u64"‿"fenster_time"

fensterInit←FensterFFI"*:i8"‿"fenster_init"‿"u32"‿"u32"‿"u32"‿"*u8:c8"
fensterGetWidth←FensterFFI"u32"‿"fenster_get_width"‿">*:i8"
fensterGetHeight←FensterFFI"u32"‿"fenster_get_height"‿">*:i8"
fensterGetPixel←FensterFFI"u32"‿"fenster_get_pixel"‿"*:i8"‿"u32"‿"u32"
fensterSetPixel←FensterFFI""‿"fenster_set_pixel"‿"*:i8"‿"u32"‿"u32"‿"u32"

OpenWindow←{𝕊w‿h‿t:
  f←FensterInit⟨w,h,1+≠t,t∾@⟩
  FensterOpen f
  FensterLoop f
  f
}

CloseWindow←{𝕊f:
  FensterClose f
  FensterLoop f
}

_render←{Func _𝕣 f:
  w←FensterGetWidth f
  h←FensterGetHeight f
  t←FensterTime⟨⟩
  {𝕊x‿y:
    r‿g‿b←Func x‿y‿t
    c←+´(⌽256⋆↕3)×⌊r‿g‿b×255
    FensterSetPixel f‿x‿y‿c
  }¨⥊(↕w)⋈⌜↕h
  FensterLoop f
  f
}

Black←0‿0‿0˙
White←1‿1‿1˙
Gray←{𝕩‿𝕩‿𝕩}
Red←1‿0‿0˙
Green←0‿1‿0˙
Blue←0‿0‿1˙

# Convert colors from HSV to RGB.
# 𝕩 is a triple 0 ≤ h‿s‿v ≤ 360‿1‿1
# Output is a triple 0 ≤ r‿g‿b ≤ 1
HSVtoRGB←{𝕊⟨h,s,v⟩:
  c←v×s
  x←c×1-|1-2|h÷60
  m←v-c
  r‿g‿b←(⌊h÷60)⊑⟨c‿x‿0,x‿c‿0,0‿c‿x,0‿x‿c,x‿0‿c,c‿0‿x⟩
  m+r‿g‿b
}
