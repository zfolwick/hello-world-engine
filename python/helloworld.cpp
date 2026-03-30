//usr/bin/env g++ "$0" -o /tmp/a; /tmp/a "$@"; exit $?
//extension: cpp

#include <iostream>

int main() {
    using namespace std;
    cout << "Hello, World!" << endl;
    return 0;
}

