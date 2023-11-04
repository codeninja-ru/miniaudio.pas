# miniaudio.pp

pascal binding for miniaudio.h

Generated semi-automatic with h2pas and and lots of hand work in vim.
I'm not sure about the correctness of the macros, so you use it on your own risk.

uses miniaudio - v0.11.18 - 2023-08-07

**It was tested on macOS, but you can compile miniaudio.c for your platform. In general, you need to obtain an object file and update the ```${L miniaudio_lib.o}``` directive in miniaudio.pp if needed.** 

## Uage

Compile miniaudio.c for your platform with gcc and link it to miniaudio.pp.
Requirements: GCC, Free Pascal
For Windows you'll probably need to make some changes in Makefile or build the library manually.

```
make build
```

Alternatively, you can build the library and examples with debug information.


```
make debug
```

Put `miniaudio.pp` and the object file (`miniaudio_lib.obj`) into your project folder and then you can use as usual.

```pascal
program example;

uses miniaudio;

begin
  // your code is here
end.
```

See the examples.

## Help
more information about miniaudio
https://miniaud.io
