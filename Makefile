VERSION=1.7
NAME=sensors-lxpanel-plugin
INPUT=sensors.c
OUTPUT=sensors.so

all: ${OUTPUT}

${OUTPUT}: ${INPUT}
	./check_required.sh
	gcc -O2 -Wall `pkg-config --cflags glib-2.0 gtk+-2.0` \
	    -shared -fPIC ${INPUT} -lsensors -o ${OUTPUT} \
	    `pkg-config --libs glib-2.0 gtk+-2.0`

clean:
	rm -f ${OUTPUT}

install: sensors.so
	./install.sh

package:
	rm -Rf ${NAME}-${VERSION}
	mkdir ${NAME}-${VERSION}
	cp -Rf README Makefile ${INPUT} COPYING check_required.sh \
               install.sh lxpanel \
               ${NAME}-${VERSION}
	tar czvf ${NAME}-${VERSION}.tar.gz \
		 ${NAME}-${VERSION}
	rm -Rf ${NAME}-${VERSION}
