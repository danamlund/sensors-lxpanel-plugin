all: sensors.so

sensors.so: sensors.c
	gcc -Wall `pkg-config --cflags lxpanel gtk+-2.0` \
	-shared -fPIC sensors.c -lsensors -o sensors.so \
	`pkg-config --libs lxpanel gtk+-2.0`

clean:
	rm -f sensors.so

install: 
	cp sensors.so /usr/lib/lxpanel/plugins
