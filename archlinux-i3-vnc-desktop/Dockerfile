FROM rigormortiz/archlinux-i3-vnc:latest
LABEL maintainer Mike Ortiz <mike@jellydice.com>

RUN pacman -Sy && \
    pacman -S --noconfirm termite arc-gtk-theme noto-fonts \
      arc-icon-theme git gvim i3blocks i3lock firefox rarian \
      sudo lxappearance pass rofi dunst compton go gnupg && \
    mkdir /etc/firefox && \
    echo 'pref("browser.tabs.remote.autostart", false);' >> /etc/firefox/syspref.js

COPY i3_config /etc/skel/.config/i3/config
COPY i3blocks.conf /etc/skel/.config/i3/i3blocks.conf
COPY dunstrc /etc/skel/.config/dunst/dunstrc
COPY termite_config /etc/skel/.config/termite/config
COPY pexels-photo-11744.jpeg /etc/skel/Pictures/pexels-photo-11744.jpeg
