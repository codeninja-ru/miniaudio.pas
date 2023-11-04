# miniaudio.pas

pascal binding for miniaudio.h

Generated semi-automatic with h2pas and and lots of hand work in vim.
I'm not sure about the correctness of the macros, so you use it on your own risk.

uses miniaudio - v0.11.18 - 2023-08-07


## Uage

Compile miniaudio.c for your platform with gcc and link it to miniaudio.pp

```
make build
```

It was tested on macOS, but you can compile miniaudio.c for your platform. In general, you need to obtain an object file and update the ${L miniaudio_obj.o} directive in miniaudio.pp if needed.

## Help
more information about miniaudio
https://miniaud.io
