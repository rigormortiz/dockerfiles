FROM rigormortiz/archlinux-mate-vnc:latest
LABEL maintainer Mike Ortiz <mike@jellydice.com>


RUN pacman -Sy && \
    rm /*.tar.xz &&\
    pacman -S --noconfirm arc-gtk-theme \
      arc-icon-theme git gvim firefox pass \
      dbus sudo go gnupg && \
    mkdir /etc/firefox && \
    echo 'pref("browser.tabs.remote.autostart", false);' >> /etc/firefox/syspref.js

COPY pexels-photo-11744.jpeg /etc/skel/Pictures/pexels-photo-11744.jpeg
