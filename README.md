# DWMBlocks
Status bar built for my build of [DWM](/swindlesmccoop/dwm). Compatible with Linux, OpenBSD, and FreeBSD, however I have not yet written the actual functionality for FreeBSD in the scripts yet.

# Compiling and Installing
```
./configure && make && doas make install
```
Replace doas with sudo as necessary.

## Software Made to Work With This
- [DWM](https://github.com/swindlesmccoop/dwm)
- [DMenu](https://github.com/swindlesmccoop/dmenu)
- [ST](https://github.com/swindlesmccoop/st)

# Dependencies
Each module depends on a script of mine, specifically the following:
- `sb-cpuusage`
- `sb-volume`
- `sb-memory`
- `sb-cputemp`
- `sb-network`
- `sb-battery`\
All of these scripts can be found in my [dotfiles repo](https://github.com/swindlesmccoop/not-just-dotfiles) at [`.local/bin/`](https://github.com/swindlesmccoop/not-just-dotfiles/tree/master/.local/bin). Simply download each script, make them each executable, and place them somewhere in your $PATH.
