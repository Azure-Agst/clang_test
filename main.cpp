#include <iostream>
#include <include.h>
#include "c_stdout.h"
#include "cpp_cout.hpp"

int main(){
    std::cout << "Hello world!" << std::endl;
    cpp_cout();
    c_stdout();
    std::cout << "Testing math include: " << sum(2,3) << std::endl;
    return 0;
}
