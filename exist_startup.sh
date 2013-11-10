# usage: curl -L https://raw.github.com/log0/aws_startup_scripts/master/exist_startup.sh | bash

# get root
sudo -s

# install related packages
apt-get update
apt-get install -y gcc g++ python-dev git htop gfortran libopenblas-dev liblapack-dev make iotop python-virtualenv autoconf

git config --global user.name "Eric Chio"
git config --global user.email "im.ckieric@gmail.com"

mkdir -p ~/.vim/view

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

/sbin/swapon /home/ubuntu/env/swap/swap.1
