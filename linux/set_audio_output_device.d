import std.file;
import std.string;
import std.process;

void set_audio_output_device(bool notifications) {
    string get_cmd = "ponymix list | head | grep 'sink'";
    get_cmd ~= "| dmenu -p 'Select audio output device:'";
    get_cmd ~= "| awk '{ print $2 }'";

    auto device = executeShell(get_cmd);
    string[] sink = strip(device.output).split(":");
    executeShell("ponymix -d " ~ sink[0] ~ " set-default");

    // If Dunst exists on the system and switch is on;
    // show notifications.
    if ("/usr/bin/dunstify".exists && notifications) {
        string get_device = "get_audio_output_device";
        if ("/usr/local/bin/get_audio_output_device_hdmi".exists)
            get_device ~= "_hdmi";

        auto ndev = executeShell(get_device);
        string notif = "dunstify 'Set audio output device:'";
        notif ~= " '" ~ strip(ndev.output) ~ "' -t 2500";
        executeShell(notif);
    }
}

int main(string[] args) {
    // Switch for notifications.
    bool notifications = true;
    if (args.length > 1) {
        if (strip(args[1]) == "--no-notifs")
            notifications = false;
    }

    set_audio_output_device(notifications);
    return 0;
}
