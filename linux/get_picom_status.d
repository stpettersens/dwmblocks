import std.file;
import std.stdio;

void get_picom_status() {
    string status = "[PICOM]";
    if ("/tmp/picom_off".exists)
        status = "[NONE]";

    writeln(status);
}

int main() {
    get_picom_status();
    return 0;
}
