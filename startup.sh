# usage: curl -L https://raw.github.com/log0/aws_startup_scripts/master/startup.sh | bash

# get root
sudo -s

# install related packages
apt-get update
apt-get install -y gcc g++ python-dev git htop gfortran libopenblas-dev liblapack-dev make

git clone https://www.github.com/log0/aws_startup_scripts/

# install custom-compiled libraries
cd ~
cd aws_startup_scripts

tar zxvf dependencies/hdf5-1.8.11.tar.gz
cd hdf5-1.8.11
./configure --prefix=/usr/local --enable-shared --enable-hl
make install

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

# activate environment
cd ~/env/source
source bin/activate

pip install numpy
pip install scikit-learn
pip install scipy
pip install netCDF4