PREFIX  := /usr/local
CC      := clang
CFLAGS  := -pedantic -Wall -Wno-deprecated-declarations -Os
LDFLAGS := -lX11

all: options dwmblocks block_programs

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

ownweather:
	chown -R $(USER):$(USER) /opt/weather_temp

block_programs:
	cd linux && ldc2 get_picom_status.d
	cd linux && ldc2 get_bt_device.d
	cd linux && ldc2 set_audio_output_device.d
	cd linux && g++ -std=c++11 get_audio_output_device.cpp -o get_audio_output_device
	cd linux && ldc2 get_volume_ponymix.d
	cd linux && ldc2 weather_temp.d
	strip linux/get_picom_status
	strip linux/get_bt_device
	strip linux/set_audio_output_device
	strip linux/get_audio_output_device
	strip linux/get_volume_ponymix
	strip linux/weather_temp
	upx -9 linux/get_picom_status
	upx -9 linux/get_bt_device
	upx -9 linux/set_audio_output_device
	upx -9 linux/get_audio_output_device
	upx -9 linux/get_volume_ponymix
	upx -9 linux/weather_temp
	rm -f linux/*.o

clean:
	rm -f *.o *.gch dwmblocks
	rm -f linux/get_picom_status linux/get_bt_device linux/set_audio_output_device linux/get_audio_output_device
	rm -f linux/get_volume_ponymix
	rm -f linux/weather_temp

install: dwmblocks
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f dwmblocks ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/dwmblocks
	cp -f linux/battery_left ${DESTDIR}${PREFIX}/bin
	cp -f linux/battery_status ${DESTDIR}${PREFIX}/bin
	cp -f linux/is_muted ${DESTDIR}${PREFIX}/bin
	cp -f linux/wifi_network ${DESTDIR}${PREFIX}/bin
	cp -f linux/get_bt_device ${DESTDIR}${PREFIX}/bin
	cp -f linux/bluetooth_on ${DESTDIR}${PREFIX}/bin
	cp -f linux/bluetooth_off ${DESTDIR}${PREFIX}/bin
	cp -f linux/bluetooth_devices ${DESTDIR}${PREFIX}/bin
	cp -f linux/get_picom_status ${DESTDIR}${PREFIX}/bin
	cp -f linux/picom_on ${DESTDIR}${PREFIX}/bin
	cp -f linux/picom_off ${DESTDIR}${PREFIX}/bin
	cp -f linux/set_audio_output_device ${DESTDIR}${PREFIX}/bin
	cp -f linux/get_audio_output_device_hdmi ${DESTDIR}${PREFIX}/bin
	cp -f linux/get_volume_ponymix ${DESTDIR}${PREFIX}/bin
	cp linux/weather_temp.cfg /etc
	cp -f linux/weather_temp ${DESTDIR}${PREFIX}/bin
	cp -f linux/start-ulauncher ${DESTDIR}${PREFIX}/bin
	cp -f linux/iss_location ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/battery_left
	chmod 755 ${DESTDIR}${PREFIX}/bin/battery_status
	chmod 755 ${DESTDIR}${PREFIX}/bin/is_muted
	chmod 755 ${DESTDIR}${PREFIX}/bin/wifi_network
	chmod 755 ${DESTDIR}${PREFIX}/bin/get_bt_device
	chmod 755 ${DESTDIR}${PREFIX}/bin/bluetooth_on
	chmod 755 ${DESTDIR}${PREFIX}/bin/bluetooth_off
	chmod 755 ${DESTDIR}${PREFIX}/bin/bluetooth_devices
	chmod 755 ${DESTDIR}${PREFIX}/bin/get_picom_status
	chmod 755 ${DESTDIR}${PREFIX}/bin/picom_on
	chmod 755 ${DESTDIR}${PREFIX}/bin/picom_off
	chmod 755 ${DESTDIR}${PREFIX}/bin/set_audio_output_device
	chmod 755 ${DESTDIR}${PREFIX}/bin/get_audio_output_device_hdmi
	chmod 755 ${DESTDIR}${PREFIX}/bin/get_volume_ponymix
	chmod 755 ${DESTDIR}${PREFIX}/bin/weather_temp
	chmod 755 ${DESTDIR}${PREFIX}/bin/start-ulauncher
	chmod 755 ${DESTDIR}${PREFIX}/bin/iss_location

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/dwmblocks

.PHONY: all options clean install uninstall
