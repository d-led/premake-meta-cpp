#include <iostream>
#include <boost/system/system_error.hpp>
#include <boost/filesystem.hpp>

int main() {
    std::cout << "current path: " << absolute(boost::filesystem::current_path()).generic_string() << std::endl;
    try {
        throw boost::system::system_error(boost::system::error_code(),"bla");
    }
    catch (std::exception&) {
        []{std::cout << "test ok" << std::endl; }();
    }
}
