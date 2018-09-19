FROM rigormortiz/archlinux-i3-vnc-base:latest
LABEL maintainer Mike Ortiz <mike@jellydice.com>

COPY nerd-fonts.pkg.tar.xz /nerd-fonts.pkg.tar.xz

RUN pacman -Sy && \
    pacman -U --noconfirm /nerd-fonts.pkg.tar.xz && \
    rm /*.tar.xz &&\
    pacman -S --noconfirm termite arc-gtk-theme \
      arc-icon-theme git gvim i3blocks i3lock firefox\
      rarian sudo lxappearance pass \
      rofi dunst compton go gnupg && \
    mkdir /etc/firefox && \
    echo 'user_pref("browser.tabs.remote.autostart", false);' >> /etc/firefox/syspref.js

COPY i3_config /etc/skel/.config/i3/config
COPY i3blocks.conf /etc/skel/.config/i3/i3blocks.conf
COPY dunstrc /etc/skel/.config/dunst/dunstrc
COPY termite_config /etc/skel/.config/termite/config
COPY pexels-photo-11744.jpeg /etc/skel/Pictures/pexels-photo-11744.jpeg
