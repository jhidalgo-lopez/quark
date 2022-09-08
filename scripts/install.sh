#!/bin/sh
apk add cmake linux-headers git make gcc g++ tar gzip curl zlib-dev bzip2-dev hwloc-dev autoconf libtbb-dev

# TODO custom install folder for libs and bins

#cd /
#git clone https://github.com/jhidalgo-lopez/quark.git

# TBB
cd
git clone https://github.com/oneapi-src/oneTBB.git
cd oneTBB
mkdir build && cd build
cmake -DTBB_TEST=OFF -DCMAKE_INSTALL_PREFIX=/quark/external/tbb/ ..
cmake --build . -j 12 
cmake --install .

# TBB2
cd
curl -L -k https://distfiles.macports.org/tbb/tbb43_20150424oss_src.tgz -o tbb.tgz
tar xf tbb.tgz
cd tbb43_20150424oss
mkdir -p /quark/external/install/include/tbb/
cp -r include/tbb/* /quark/external/install/include/tbb/

# BOOST
cd /quark/external
tar xzf boost_1_59_0.tar.gz
mkdir -p /quark/external/install/include/boost/
cp -r boost_1_59_0/* /quark/external/install/include/boost/


# zlib
cd
curl -k -L http://download.savannah.gnu.org/releases/lzip/lzlib/lzlib-1.9.tar.gz -o lzlib.tar.gz
tar -xf lzlib.tar.gz
cd lzlib-1.9/ && ./configure && make check
make -j12 install

# lzip
cd
curl -k -L  http://download.savannah.gnu.org/releases/lzip/lzip-1.23.tar.gz -o lzip.tar.gz
tar -xf lzip.tar.gz
cd lzip-1.23 && ./configure && make check
make -j12 install

#plzip
cd
curl -k -L  http://download.savannah.gnu.org/releases/lzip/plzip/plzip-1.9.tar.lz -o plzip.tar.lz
lzip plzip.tar.lz -cd | tar xf - || exit 1
cd plzip-1.9 && ./configure && make check
make -j12 install

# RapMap
cd /quark/external
. /quark/scripts/fetchRapMap.sh

cd /quark
mkdir build
cd build
cmake -DFETCH_BOOST=FALSE ..
cmake --build . -j 12  1> /quark/build_stdin.log 2> /quark/build_stdout.log 
cd ..
