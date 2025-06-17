import std.file;
import std.conv;
import std.stdio;
import std.string;
import core.thread;
import std.process;
import std.algorithm;

struct weather_opts {
    float latitude;
    float longitude;
    string timezone;
    char unit;
}

int get_weather_temp(weather_opts w) {
    string req = format("https://api.open-meteo.com/v1/forecast?latitude=%.2f", w.latitude);
    req ~= format("&longitude=%.2f&hourly=temperature_2m&current=temperature_2m", w.longitude);
    req ~= format("&timezone=%s", w.timezone);

    string workaround = "";
    version(Windows) {
        workaround = " -k ";
    }

    auto api = executeShell
    (format("curl -s%s \"%s\" | jq .current.temperature_2m", workaround, req));
    if (api.status != 0) {
        writeln("Failed to get weather temp.");
        return -1;
    }

    float curr_temp = to!float(strip(api.output));

    if (w.unit == 'F') {
        curr_temp = ((curr_temp * 2) + 30);
    }
    else if (w.unit == 'K') {
        curr_temp = (curr_temp + 273.15);
    }

    writefln("%.1f %s", curr_temp, w.unit);

    return 0;
}

weather_opts read_config_file() {
    weather_opts w;
    string cfg = "weather_cfg";
    if ("weather_cfg".exists) {
        auto f = File(cfg);
        foreach (line; f.byLine()) {
            string l = to!string(line);
            if (l.startsWith("#")) {
                // Ignore any comment lines in configuration file.
                continue;
            }

            if (l.canFind(",")) {
                auto ll = l.split(",");
                w.latitude = to!float(ll[0]);
                w.longitude = to!float(ll[1]);
                continue;
            }

            if (l.canFind("/")) {
                w.timezone = l;
                continue;
            }

            if (l.canFind("F") || l.canFind("C") || l.canFind("K")) {
                w.unit = to!char(l);
                continue;
            }
        }
        return w;
    }

    // Use New York City if a configuration file is unavailable.
    w.latitude = 40.71427;
    w.longitude = -74.00597;
    w.timezone = "America/New_York";
    w.unit = 'F';

    return w;
}

int main() {
	int status = 0;
	while (true) {
		status = get_weather_temp(read_config_file());
		if (status == -1)
			break;

		// Refresh temperature status every hour.
		Thread.sleep(dur!("seconds")(3600));
	}
    return status;
}
