PREFIX  := /usr/local
CC      := cc
CFLAGS  := -pedantic -Wall -Wno-deprecated-declarations -Os
LDFLAGS := -lX11

LDFLAGS += -L/usr/local/lib -I/usr/local/include

all: options dwmblocks

original:
	@echo Configuring blocks.h for Month Day and time
	cp -f blocks_original.h blocks.h

isotime:
	@echo Configuring blocks.h for isotime
	cp -f blocks_isotime.h blocks.h

battery:
	@echo Configuring blocks.h for isotime + battery
	cp -f blocks_battery.h blocks.h

options:
	@echo dwmblocks build options:
	@echo "CFLAGS  = ${CFLAGS}"
	@echo "LDFLAGS = ${LDFLAGS}"
	@echo "CC      = ${CC}"

dwmblocks: dwmblocks.c blocks.h
	${CC} -o dwmblocks dwmblocks.c ${CFLAGS} ${LDFLAGS}

clean:
	rm -f *.o *.gch dwmblocks

install: dwmblocks
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f dwmblocks ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/dwmblocks
	cp -f freebsd/battery_left ${DESTDIR}${PREFIX}/bin
	cp -f freebsd/battery_status ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/battery_left
	chmod 755 ${DESTDIR}${PREFIX}/bin/battery_status

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dwmblocks

.PHONY: all options clean install uninstall
