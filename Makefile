EXAMPLE_TARGETS = example_simple_playback_sine example_simple_playback example_beep example_engine_hello_world example_engine_custom_data_source
MINIAUDIO_SOURCE = miniaudio_lib.c
MINIAUDIO_OUT = miniaudio_lib.o
.PHONY: examples debug build

clean:
	-rm *.res
	-rm *.o
	-rm *.ppu
	-rm $(EXAMPLE_TARGETS)

miniaudio:
	@echo "Build: $(MINIAUDIO_SOURCE)"
	gcc $(flag) -c $(MINIAUDIO_SOURCE) -o $(MINIAUDIO_OUT)

$(EXAMPLE_TARGETS):
	@echo "Build example: $@"
	fpc $(flag) $@.pas

examples: $(EXAMPLE_TARGETS)

build: clean miniaudio examples

crossbuild: clean
	@echo "Corss Build: $(MINIAUDIO_SOURCE)"
	x86_64-linux-gnu-gcc $(flag) -c $(MINIAUDIO_SOURCE) -o miniaudio_lib-linux-x86_64.o
	x86_64-w64-mingw32-gcc $(flag) -c $(MINIAUDIO_SOURCE) -o miniaudio_lib-win64-x86_64.o
	i686-w64-mingw32-gcc-win32 $(flag) -c $(MINIAUDIO_SOURCE) -o miniaudio_lib-win32-i686.o
	i686-linux-gnu-gcc $(flag) -c $(MINIAUDIO_SOURCE) -o miniaudio_lib-linux-i686.o

debug: flag = -g

debug: build
