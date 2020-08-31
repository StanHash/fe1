#!/bin/bash

base_dir=$(dirname "$(readlink -f "$0")")

cd $base_dir

git clone https://github.com/vhelin/wla-dx.git
cd wla-dx

mkdir build
cd build

cmake .. -DCMAKE_INSTALL_PREFIX="$base_dir"
cmake --build . --config Release
cmake -P cmake_install.cmake
