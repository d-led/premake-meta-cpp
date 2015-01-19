#include <iostream>
#include <boost/system/system_error.hpp>
int main() {
    try {
        throw boost::system::system_error(boost::system::error_code(),"bla");
    }
    catch (std::exception&) {
        []{std::cout << "test ok" << std::endl; }();
    }
}
