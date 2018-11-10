curl -s -L -o  boost_1_68_0.tar.bz2 https://dl.bintray.com/boostorg/release/1.68.0/source/boost_1_68_0.tar.bz2 
tar -xvf boost_1_68_0.tar.bz2 
cd boost_1_68_0 
./bootstrap.sh 
./b2 --build-type=minimal link=static runtime-link=static --with-chrono --with-date_time --with-filesystem --with-program_options --with-regex --with-serialization --with-system --with-thread --with-locale threading=multi threadapi=pthread cflags="-fPIC" cxxflags="-fPIC" stage
sudo ./bjam cxxflags=-fPIC cflags=-fPIC -a install
