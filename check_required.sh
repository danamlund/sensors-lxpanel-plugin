#!/bin/bash

pkgcheck() {
  PKGNAME=$1
  DEBIANPKG=$2

  pkg-config --cflags $PKGNAME > /dev/null 2>&1
  if [ $? -eq 1 ] 
  then
      echo missing $PKGNAME. sudo apt install $DEBIANPKG
      exit 1
  fi

}

pkgcheck glib-2.0 libglib2.0-dev

pkgcheck gtk+-2.0 libgtk2.0-dev

headercheck() {
    HEADERFILE=$1
    DEBIANPKG=$2

    FOUND="NO"

    for path in /usr/local/include /usr/include
    do
        if [ -f $path/$HEADERFILE ]
        then
            FOUND="YES"
        fi
    done

    if [ $FOUND == "NO" ]
    then
        echo Missing $HEADERFILE. sudo apt-get install $DEBIANPKG
        exit 1
    fi
}

headercheck sensors/sensors.h libsensors4-dev
