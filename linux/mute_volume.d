import std.file;
import std.string;
import std.process;

void toggle_mute_audio_output_device(bool notifications) {
    executeShell("ponymix toggle");
    if ("/usr/bin/dunstify".exists && notifications) {
        string get_device = "get_audio_output_device";
        if ("/usr/local/bin/get_audio_output_device_hdmi".exists)
            get_device ~= "_hdmi";

        auto ndev = executeShell(get_device);
        auto is_muted = executeShell("ponymix is-muted");

        string notif = "dunstify '" ~ strip(ndev.output) ~ ":'";
        if (is_muted.status == 0)
            notif ~= " 'Muted' -t 2500 -u 2";
        else
            notif ~= " 'Audio on' -t 2500 -u 1";

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

    toggle_mute_audio_output_device(notifications);
    return 0;
}
