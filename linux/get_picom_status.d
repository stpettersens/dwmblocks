import std.file;
import std.stdio;

void get_picom_status() {
    string status = "[PICOM ON]";
    if ("/ramdisk/picom_off".exists)
        status = "[PICOM OFF]";

    writeln(status);
}

int main() {
    get_picom_status();
    return 0;
}
