#include <iostream>

extern double series();

int main() {
    double number = series();

    std::cout << "The driver received this number " << number << ", and will keep it." << std::endl;
    std::cout << "Goodbye";
    
    return 0;
}