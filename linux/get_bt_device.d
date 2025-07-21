import std.file;
import std.array;
import std.stdio;
import std.string;
import std.process;

void get_bt_device() {
    if ("/tmp/bluetooth_off".exists) {
        writeln("[DISABLED]");
        return;
    }

    string list_cmd = "bluetoothctl devices";
    auto is_rpi = executeShell("whereis vcgencmd");
    if (strip(is_rpi.output).indexOf("not found") == -1) {
        writeln("[NONE]");
        list_cmd = "bluetoothctl list";
    }

    auto bt_ctl = executeShell(list_cmd);
    if (strip(bt_ctl.output) == "No default controller available") {
        writeln("[NO RECEIVER]");
        return;
    }

    auto info = executeShell("bluetooth_devices");
    if (strip(info.output).length == 0)
        return;

    string[] split_info = info.output.split("\n");
    split_info.popBack();

    string[] devices = new string[0];
    for (int i = 0; i < split_info.length; i += 2) {
        string d = strip(split_info[i].split("Name:")[1]);
        d ~= '=';
        d ~= strip(split_info[(i+1)].split("Connected:")[1]);
        devices ~= d;
    }

    string device = "NONE";
    foreach (bt; devices) {
        string[] btd = bt.split("=");
        if (btd[1] == "yes")
            device = btd[0];
    }

    writefln("[%s]", device);
}

int main() {
    get_bt_device();
    return 0;
}
