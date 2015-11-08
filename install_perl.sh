#!/bin/bash

PLENV_ROOT=/opt/plenv

BUILD_OPTS="-j9 -Dman1dir=none -Dman3dir=none -Dsiteman1dir-none -Dsiteman3dir=none"

if pushd $PLENV_ROOT; then
    git pull
    popd
else
    git clone git://github.com/tokuhirom/plenv.git $PLENV_ROOT
fi

if pushd $PLENV_ROOT/plugins/perl-build; then
    git pull
    popd
else
    git clone git://github.com/tokuhirom/Perl-Build.git $PLENV_ROOT/plugins/perl-build
fi

. /etc/profile

cat perls.txt | while read version
do
    echo "Building perl $version"

    plenv install $BUILD_OPTS $version
    plenv rehash
done
