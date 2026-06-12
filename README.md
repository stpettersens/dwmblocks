#### Tweak by stpettersens
This fork of swindlemccoop's dwmblocks goes with my fork of his [dwm build](https://github.com/stpettersens/dwm).

**WARNING: I have NOT updated this fork for FreeBSD in a while.**

I have written some of my own bash scripts and D programs to provide
blocks on dwmblocks.

Requirements:
* [bash](http://en.wikipedia.org/wiki/Bash_(Unix_shell))
* [ldc2 (D LLVM compiler)](https://github.com/ldc-developers/ldc)
* [upx](https://github.com/upx/upx)

Run to configure blocks.h:
* > `make isotime` to just display the YYY-MM-DD, HH:MM time.
* > `make battery` to display the YYY-MM-DD, HH:MM time and battery left/status.
* > `make original` to just display Month Day and time.

# DWMBlocks
Status bar built for my build of [DWM](/swindlesmccoop/dwm). Compatible with Linux, OpenBSD, and FreeBSD, however I have not yet written the actual functionality for FreeBSD in the scripts yet.

# Compiling and Installing
```
./configure && make && doas make install
```
Replace doas with sudo as necessary.
