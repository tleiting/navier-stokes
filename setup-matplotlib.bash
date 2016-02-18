#! /bin/bash
[[ "${BASH_SOURCE[0]}" != "${0}" ]] || (echo To run this script, type '"'source "$0"'"' in the terminal where you"'"ll be working. && exit 1) || return

function yes_no {
    read -n 1 -p "$1" REPLY
    echo
}

VERSION=$(python --version 2>&1 | sed 's/.* \([0-9]\.[0-9]\).*/\1/')
PREREQ="$HOME/mock-1.1.0.tar.gz"
UNPACKED_PREREQ="$HOME/mock-1.1.0"
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
    curl -o "$PREREQ" 'https://pypi.python.org/packages/source/m/mock/mock-1.1.0.tar.gz#md5=9350792aa747cb044c6576cf9f1568b9' || return
    curl -o "$DOWNLOAD" 'http://poetical-science.org/matplotlib-1.4.2.tar.gz' || return
    
    pushd $HOME
    echo "$PREREQ"
    tar xvfz "$PREREQ" || return
    cd $UNPACKED_PREREQ
    python setup.py build || return
    python setup.py install --prefix="$INSTALLED" || python setup.py install --prefix="$INSTALLED" || return
    cd ..
    echo "$DOWNLOAD"
    tar xvfz "$DOWNLOAD" || return
    cd $UNPACKED
    python setup.py build || return
    python setup.py install --prefix="$INSTALLED" || python setup.py install --prefix="$INSTALLED" || return
    popd
fi
