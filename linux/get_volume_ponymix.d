import std.stdio;
import std.string;
import std.process;

void get_volume_ponymix() {
    string get_vol = "ponymix | grep 'Volume' | head -1 | awk '{ print $3 }'";
    auto volume = executeShell(get_vol);
    writefln("[%s]", strip(volume.output));
}

int main() {
    get_volume_ponymix();
    return 0;
}
