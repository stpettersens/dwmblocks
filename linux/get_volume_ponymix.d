import std.stdio;
import std.string;
import std.process;

int get_volume_ponymix() {
    string get_vol = "ponymix | grep 'Volume' | head -1 | awk '{ print $3 }'";
    auto volume = executeShell(get_vol);
    if (volume.status != 0) {
        writeln("ERROR");
        return -1;
    }
    writefln("[%s]", strip(volume.output).replace("%", " %"));
    return 0;
}

int main() {
    return get_volume_ponymix();
}
