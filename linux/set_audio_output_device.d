import std.string;
import std.process;

void set_audio_output_device() {
    string get_cmd = "ponymix list | grep 'sink' | head -n -1";
    get_cmd ~= "| dmenu -p 'Select audio output device:'";
    get_cmd ~= "| awk '{ print $2 }'";

    auto device = executeShell(get_cmd);
    string[] sink = strip(device.output).split(":");
    executeShell("ponymix -d " ~ sink[0] ~ " set-default");
}

int main() {
    set_audio_output_device();
    return 0;
}
