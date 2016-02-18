#! /bin/bash
[[ "${BASH_SOURCE[0]}" != "${0}" ]] || (echo To run this script, type '"'source "$0"'"' in the terminal where you"'"ll be working. && exit 1) || return

function yes_no {
    read -n 1 -p "$1" REPLY
    echo
}

VERSION=$(python --version 2>&1 | sed 's/.* \([0-9]\.[0-9]\).*/\1/')
DOWNLOAD="$HOME/matplotlib-1.4.2.tar.gz"
UNPACKED="$HOME/matplotlib-1.4.2"
INSTALLED="$HOME/matplotlib-installation"
PACKAGES="$INSTALLED/lib/python$VERSION/site-packages"

echo Updating PYTHONPATH.
export PYTHONPATH="$PACKAGES:$PYTHONPATH"

echo Installing.
REPLY='n'
if [ -e "$INSTALLED" ]
then
    yes_no "matplotlib seems to already be installed.  Skip the installation step (Y/n)? "
fi

if [[ $REPLY =~ ^[Nn]$ ]]
then
    rm -rf "$DOWNLOAD" "$UNPACKED" "$INSTALLED"
    mkdir -p "$PACKAGES" || return
    curl -o "$DOWNLOAD" 'http://softlayer-dal.dl.sourceforge.net/project/matplotlib/matplotlib/matplotlib-1.4.2/matplotlib-1.4.2.tar.gz' || return
    
    pushd $HOME
    echo "$DOWNLOAD"
    tar xvfz "$DOWNLOAD" || return
    cd $UNPACKED
    python setup.py build || return
    python setup.py install --prefix="$INSTALLED" || python setup.py install --prefix="$INSTALLED" || return
    popd
fi
