VERSION=1.1

all: sensors.so

sensors.so: sensors.c
	gcc -O2 -Wall `pkg-config --cflags lxpanel gtk+-2.0` \
	-shared -fPIC sensors.c -lsensors -o sensors.so \
	`pkg-config --libs lxpanel gtk+-2.0`

clean:
	rm -f sensors.so

install: 
	if [ -d "/usr/lib/lxpanel/plugins" ]; then \
	  cp sensors.so /usr/lib/lxpanel/plugins; \
	elif [ -d "/usr/lib64/lxpanel/plugins" ]; then \
	  cp sensors.so /usr/lib64/lxpanel/plugins; \
	else \
	  echo ;\
	  echo Couldn\'t find lxpanel/plugins directory.; \
	  echo Checked /usr/lib/lxpanel/plugins and /usr/lib64/lxpanel/plugins; \
	  echo Find it yourself by running \'locate deskno.so\'; \
	  echo Then copy sensors.so to that directory.; \
	fi

package:
	rm -Rf sensors-lxpanel-plugin-${VERSION}
	mkdir sensors-lxpanel-plugin-${VERSION}
	cp README Makefile sensors.c sensors-lxpanel-plugin-${VERSION}
	tar czvf sensors-lxpanel-plugin-${VERSION}.tar.gz \
		 sensors-lxpanel-plugin-${VERSION}
	rm -Rf sensors-lxpanel-plugin-${VERSION}
