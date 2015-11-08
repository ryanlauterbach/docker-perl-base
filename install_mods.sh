#!/bin/bash

# Note: 5.22.0 doesn't support Coro and therefore Task::Plack.
# stableperl 5.22.0 does, but perl-build doesn't support stableperl
# See perl-build tag 1.12
# TODO: patch perl-build

. /etc/profile

cat perls.txt | while read version
do
    echo "Installing modules for $version"

    plenv local $version
    echo -n "Setting perl version "
    plenv version
    plenv install-cpanm

    echo -n "cpanm shim path set to "
    command -v cpanm
    echo -n "cpanm executable path set to "
    plenv which cpanm

    cat mods.txt | cpanm -n
done

rm -rf ~/.cpanm $PLENV_ROOT/build/*
