#include <iostream>
#include <string>

// This program uses cpp-subprocess:
// https://github.com/tsaarni/cpp-subprocess
#include "include/subprocess.hpp"

void get_audio_output_device(bool short_hdmi_desc) {
    subprocess::popen device("ponymix", {});

    std::string sink_name, sink_desc;
    std::getline(device.out(), sink_name);
    std::getline(device.out(), sink_desc);

    std::size_t hdmi_found = sink_name.find("hdmi");
    if (short_hdmi_desc && (hdmi_found != std::string::npos))
        std::cout << "HDMI Audio" << std::endl;
    else
        std::cout << sink_desc.substr(2) << std::endl;
}

int main(int argc, char **argv) {
    // Abbreviate the HDMI device name if this flag is true.
    bool short_hdmi_desc = false;
    if (argc > 1 && std::string(argv[1]) == "--short-hdmi-desc")
        short_hdmi_desc = true;

    else if (argc > 1 && std::string(argv[1]) == "--help") {
        std::cout << "Usage: get_audio_output_device [--short-hdmi-desc]" << std::endl;
        std::cout << std::endl << "With above switch, the HDMI Audio device";
        std::cout << std::endl << "description used will be \"HDMI Audio\"." << std::endl;
        return 0;
    }

    get_audio_output_device(short_hdmi_desc);
    return 0;
}
