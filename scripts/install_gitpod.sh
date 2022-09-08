#!/bin/sh
apt install cmake linux-headers git make gcc g++ tar gzip curl

# TODO custom install folder for libs and bins

#cd /
#git clone https://github.com/jhidalgo-lopez/quark.git

# TBB
cd /workspace/quark
git clone https://github.com/oneapi-src/oneTBB.git
cd oneTBB
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/workspace/quark/external/tbb43_20140724oss -DTBB_TEST=OFF ..
cmake --build .
sudo cmake --install .

# zlib
cd /workspace/quark/external
curl -k -L http://download.savannah.gnu.org/releases/lzip/lzlib/lzlib-1.9.tar.gz -o lzlib.tar.gz
tar -xf lzlib.tar.gz
cd lzlib-1.9/ && ./configure && make check
sudo make install

# lzip
cd /workspace/quark/external
curl -k -L  http://download.savannah.gnu.org/releases/lzip/lzip-1.23.tar.gz -o lzip.tar.gz
tar -xf lzip.tar.gz
cd lzip-1.23 && ./configure && make check
sudo make install

#plzip
cd /workspace/quark/external
curl -k -L  http://download.savannah.gnu.org/releases/lzip/plzip/plzip-1.9.tar.lz -o plzip.tar.lz
lzip plzip.tar.lz -cd | tar xf - || exit 1
cd plzip-1.9 && ./configure && make check
sudo make install

#cd && rm -r *


#cd /quark
#mkdir build
#cd build
#cmake ..
#make
#cd ..
