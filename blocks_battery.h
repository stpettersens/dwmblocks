//Modify this file to change what commands output to your statusbar, and recompile using the make command.
#ifdef __linux__
	#define SIG 10
#elif __OpenBSD__
	#define SIG 1
#elif __FreeBSD__
	#define SIG 1
#endif

static const Block blocks[] = {
//	  Label		   Command				Int		SIG
	{"",            "date '+%Y-%m-%d, %H:%M'", 1,           0},
	{"Battery: ",    "battery_left", 1,                      0},
	{"",            "battery_status", 1,                    0},
};

//sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
