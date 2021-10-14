#!/bin/sh

DEB_PACKAGE_NAME="protonvpn-stable-release_1.0.1-1_all"
RPM_PACKAGE_NAME="protonvpn-stable-release-1.0.0-1.noarch"

fbsd_package(){
  sudo pkg update
  sudo pkg upgrade
  sudo pkg install -y protonvpn-cli
}

deb_package(){
  sudo wget https://protonvpn.com/download/$DEB_PACKAGE_NAME.deb
  sudo dpkg -i $DEB_PACKAGE_NAME.deb
  sudo rm -f $DEB_PACKAGE_NAME.deb
  sudo apt update
  sudo apt install -y protonvpn-cli
}

rpm_package(){
  sudo wget https://protonvpn.com/download/$RPM_PACKAGE_NAME.rpm
  sudo yum install -y $RPM_PACKAGE_NAME.rpm
  sudo yum install -y protonvpn-cli
}


 if cat /etc/*release | grep ^NAME | grep Fedora; then
    echo "==============================================="
    echo "Installing packages $RPM_PACKAGE_NAME on Fedora"
    echo "==============================================="

    rpm_package


 elif cat /etc/*release | grep ^NAME | grep Ubuntu; then
    echo "==============================================="
    echo "Installing packages $DEB_PACKAGE_NAME on Ubuntu"
    echo "==============================================="

    deb_package

 elif cat /etc/*release | grep ^NAME | grep Debian; then
    echo "==============================================="
    echo "Installing packages $DEB_PACKAGE_NAME on Debian"
    echo "==============================================="

    rpm_package

elif uname -a | awk '{ print $1}' | grep FreeBSD; then
    echo "================================================="
    echo "Installing packages $PKG_PACKAGE_NAME on FreeBSD"
    echo "================================================="

    fbsd_package 

 else
    echo "OS NOT DETECTED, couldn't install protonvpn-cli"
    exit 1;
 fi

exit 0
