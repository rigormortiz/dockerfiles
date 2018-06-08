FROM rigormortiz/archlinux-i3-vnc-base:latest
LABEL maintainer Mike Ortiz <mike@jellydice.com>

COPY nerd-fonts.pkg.tar.xz /nerd-fonts.pkg.tar.xz

RUN pacman -Sy && \
    pacman -U --noconfirm /nerd-fonts.pkg.tar.xz && \
    rm /*.tar.xz &&\
    pacman -S --noconfirm termite arc-gtk-theme \
      arc-icon-theme git gvim i3blocks i3lock firefox\
      libreoffice-fresh lxappearance pidgin pidgin-sipe \
      perl-xml-parser docbook-xml rarian sudo \
      rofi dunst compton chromium git go gnupg

COPY i3_config /etc/skel/.config/i3/config
COPY i3blocks.conf /etc/skel/.config/i3/i3blocks.conf
COPY dunstrc /etc/skel/.config/dunst/dunstrc
COPY termite_config /etc/skel/.config/termite/config
COPY pexels-photo-11744.jpeg /etc/skel/Pictures/pexels-photo-11744.jpeg
