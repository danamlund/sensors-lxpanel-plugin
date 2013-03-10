PACKAGE INFORMATION
===================

A lxpanel plugin to monitor hardware sensors through lm-sensors.


DEPENDENCIES
============

This package uses several other packages with different names
depending on distribution.

For Ubuntu 11.04:
  lxpanel
  pkg-config
  libglib2.0-dev
  libgtk2.0-dev
  libsensors4-dev
  libmenu-cache1-dev

For Debian systems the additional package is needed:
  lxpanel-dev

For Fedora 16:
  lm_sensors-devel
  lxpanel-devel
  gtk2-devel


INSTALLATION
============

To install this package run on a fresh ubuntu 11.04 system:
  sudo apt-get install build-essential lxde
  sudo apt-get install libglib2.0-dev libgtk2.0-dev libmenu-cache1-dev 
  sudo apt-get install libsensors4-dev
  make
  sudo make install

To install in Funtoo/Gentoo:
  See Tutu Yakubu's installer at:
    https://github.com/yuyuyak/sensors-lxpanel-plugin-ebuild

On debian (and possible other systems) the package 'lxpanel-dev' is
also needed: 
  sudo apt-get install lxpanel-dev

Make sure you have run 'sudo sensors-detect' or otherwise configured
lm-sensors. You can test your lm-sensors configuration by running
'sensors'.


USAGE
=====

Once installed, follow these steps to add the plugin:
  Right-click panel
  Select "Add / Remove Panel Items"
  Press "Add"
  Select and add "lm-sensors Monitor"
  Right-click plugin to change settings

To monitor multiple sensors, add multiple sensors plugins.


AUTHOR INFORMATION
==================

Author: Dan Amlund Thomsen
Email: dan@danamlund.dk
Website: http://danamlund.dk/sensors_lxpanel_plugin


CHANGELOG
=========

1.0 (2012-03-12)
  Initial release

1.1 (2013-03-06) 
  Widget size is kept as the maximum seen to avoid jiggling other
  plugins. Widget size can be reset by entering the configuration.

1.2 (2013-03-10)
  Text is now aligned to the right in the x-coordinate and in the
  center on the y-coordinate. The text is now customizable using html
  markup.
