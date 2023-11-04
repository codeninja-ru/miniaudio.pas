clean:
	-rm *.res
	-rm *.o
	-rm *.ppu
build: clean
	gcc -c miniaudio.c -o miniaudio_obj.o
	fpc example_simple_playback_sine.pas
	fpc example_simple_playback.pas
debug: clean
	gcc -g -c miniaudio.c -o miniaudio_obj.o
	fpc -g example_simple_playback_sine.pas
	fpc -g example_simple_playback.pas
