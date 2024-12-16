import std.file;
import std.array;
import std.stdio;
import std.string;
import std.process;

void get_bt_device() {
    if ("/ramdisk/bluetooth_off".exists) {
        writeln("[DISABLED]");
        return;
    }

    auto btctl = executeShell("bluetoothctl devices");
    if (strip(btctl.output) == "No default controller available") {
        writeln("[NO RECEIVER]");
        return;
    }

    auto info = executeShell("bluetooth_devices");
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
