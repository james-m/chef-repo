#!/bin/bash
#
LIB_PATH=/opt/lib
LEVELDB_VER=1.9.0
SNAPPY_VER=1.1.0
LEVELDB_LIB_PATH=$LIB_PATH/leveldb-$LEVELDB_VER
SNAPPY_LIB_PATH=$LIB_PATH/snappy-$SNAPPY_VER

echo "LEVELDB PATH $LEVELDB_LIB_PATH";
echo "SNAPPY PATH $SNAPPY_LIB_PATH";

# install snappy. 
#
echo "Installing snappy compression libraries.";
pushd $SNAPPY_LIB_PATH;
./autogen.sh;
./configure;
make && make install;
popd

echo "Installing leveldb libraries.";
pushd $LEVELDB_LIB_PATH
make
cp -r $LEVELDB_LIB_PATH/include/leveldb /usr/local/include/
cp -r $LEVELDB_LIB_PATH/libleveldb.so.1.9 /usr/local/lib
pushd /usr/local/lib
ln -fs libleveldb.so.1.9 libleveldb.so 
ln -fs libleveldb.so.1.9 libleveldb.so.1
ldconfig
popd
popd
