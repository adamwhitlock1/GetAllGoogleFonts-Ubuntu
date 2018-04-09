#!/bin/sh

# Written by: Keefer Rourke <https://krourke.org>
# Based on AUR package <https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=ttf-google-fonts-git>
# Modified for Ubuntu Linux 17.10 by Adam Whitlock <https://github.com/adamwhitlock1>

# dependencies: git
if [ $(dpkg-query -W -f='${Status}' git 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  echo -e "Dependency Git not found! Install? (y/n) \c"
  read
  if "$REPLY" = "y"; then
      sudo apt-get install git
  fi
else
  echo "Dependency Git is installed\n++++++++++++++++++++++++++++++++++++++\nContinuing Install of All Google Fonts\n++++++++++++++++++++++++++++++++++++++"
fi
srcdir="/tmp/google-fonts"
pkgdir="/usr/share/fonts/truetype/google-fonts"
giturl="git://github.com/google/fonts.git"

mkdir $srcdir
cd $srcdir
echo "Cloning Git repository..."
git clone $giturl

echo "Installing Google fonts to path $pkgdir"
sudo mkdir -p $pkgdir
sudo find $srcdir -type f -name "*.ttf" -exec install -Dm644 {} $pkgdir \;

sudo apt-get --purge remove fonts-roboto

echo "Updating font-cache..."
sudo fc-cache -f > /dev/null

echo "Removing temp directory"
sudo rm -rf $srcdir

echo "All Done! Enjoy"
