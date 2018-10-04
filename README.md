# SimplePlayer

A simple media player based on VLC's MobileVLCKit

This is a simple test project based around [videolan/vlckit](https://github.com/videolan/vlckit).

The project makes use of carthage's depedency management system to manage it's dependencies, a simple `update.sh` script can be used to update the dependencies

There are no video controls at this time, as this wasn't part of the intended test

# Improvements

* Hide the controls automatically after a specified period of time
  When the user taps the UI, the page controls and setting controls are showen/hidden.  In line with many other video players, it might be an idea to automatically hide the controls again after a specified period of time