clean:
	-rm *.res
	-rm *.o
	-rm *.ppu
build: clean
	gcc -c miniaudio.c -o miniaudio_obj.o
debug: clean
	gcc -g -c miniaudio.c -o miniaudio_obj.o
	fpc -g example_simple_playback_sine.pas
