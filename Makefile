EXAMPLE_TARGETS = example_simple_playback_sine example_simple_playback example_beep
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

debug: flag = -g

debug: build
