PREFIX  := /usr/local
CC      := cc
CFLAGS  := -pedantic -Wall -Wno-deprecated-declarations -Os
LDFLAGS := -lX11

all: options dwmblocks

original:
	@echo Configuring blocks.h for Month Day and time
	cp -f blocks_original.h blocks.h

isotime:
	@echo Configuring blocks.h for isotime
	cp -f  blocks_isotime.h blocks.h

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
	cp -f linux/battery_left ${DESTDIR}${PREFIX}/bin
	cp -f linux/battery_status ${DESTDIR}${PREFIX}/bin
	cp -f linux/get_volume ${DESTDIR}${PREFIX}/bin
	cp -f linux/is_muted ${DESTDIR}${PREFIX}/bin
	cp -f linux/get_bt_device ${DESTDIR}${PREFIX}/bin
	cp -f linux/bluetooth_on ${DESTDIR}${PREFIX}/bin
	cp -f linux/bluetooth_off ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/battery_left
	chmod 755 ${DESTDIR}${PREFIX}/bin/battery_status
	chmod 755 ${DESTDIR}${PREFIX}/bin/get_volume
	chmod 755 ${DESTDIR}${PREFIX}/bin/is_muted
	chmod 755 ${DESTDIR}${PREFIX}/bin/get_bt_device
	chmod 755 ${DESTDIR}${PREFIX}/bin/bluetooth_on
	chmod 755 ${DESTDIR}${PREFIX}/bin/bluetooth_off


uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dwmblocks

.PHONY: all options clean install uninstall
