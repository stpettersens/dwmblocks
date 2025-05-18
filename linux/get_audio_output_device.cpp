#include <iostream>
#include <string>

#include "include/subprocess.hpp"

void get_audio_output_device() {
    subprocess::popen device("ponymix", {});

    std::string sink_name, sink_desc;
    std::getline(device.out(), sink_name);
    std::getline(device.out(), sink_desc);

    std::cout << sink_desc.substr(10, sink_desc.length()) << std::endl;
}

int main() {
    get_audio_output_device();
    return 0;
}
