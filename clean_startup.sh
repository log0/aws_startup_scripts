# usage: curl -L https://raw.github.com/log0/aws_startup_scripts/master/clean_startup.sh | bash

# get root
sudo -s

# install related packages
apt-get update
apt-get install -y gcc g++ python-dev git htop gfortran libopenblas-dev liblapack-dev make iotop python-virtualenv autoconf

git clone https://www.github.com/log0/aws_startup_scripts/

# install custom-compiled libraries
cd ~
cd aws_startup_scripts

tar zxvf dependencies/hdf5-1.8.11.tar.gz
cd hdf5-1.8.11
./configure --prefix=/usr/local --enable-shared --enable-hl
make install

cd ~
cd aws_startup_scripts

tar zxvf dependencies/netcdf-4.3.0.tar.gz
cd netcdf-4.3.0
LDFLAGS=-L/usr/local/lib CPPFLAGS=-I/usr/local/include ./configure --enable-netcdf-4 --enable-dap --enable-shared --prefix=/usr/local
make install

# mount our required disk
cd ~
mkdir ~/env
mount /dev/xvdf1 ~/env

# prepare keys
cp ~/env/keys/* ~/.ssh

# prepare home
cp ~/env/home/.* ~/

# activate environment
cd ~/env/source_2

source bin/activate

pip install numpy
pip install scipy
pip install scikit-learn
pip install netCDF4

# MANUAL steps. update LD_LIBRARY_PATH to profile;
# cd ~/env/source_2/source/mkl/l_mkl_11.1.0.080
# ./install.sh
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/composer_xe_2013_sp1.0.080/mkl/lib/intel64:/opt/intel/composer_xe_2013_sp1.0.080/mkl/lib/ia32
# echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/intel/composer_xe_2013_sp1.0.080/mkl/lib/intel64:/opt/intel/composer_xe_2013_sp1.0.080/mkl/lib/ia32' >> ~/.bash_profile