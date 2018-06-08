FROM rigormortiz/archlinux-mate-vnc-base:latest
LABEL maintainer Mike Ortiz <mike@jellydice.com>

COPY nerd-fonts.pkg.tar.xz /nerd-fonts.pkg.tar.xz

RUN pacman -Sy && \
    pacman -U --noconfirm /nerd-fonts.pkg.tar.xz && \
    rm /*.tar.xz &&\
    pacman -S --noconfirm arc-gtk-theme chromium \
      arc-icon-theme git gvim firefox qutebrowser \
      dbus pidgin pidgin-sipe sudo \
      git go gnupg

COPY pexels-photo-11744.jpeg /etc/skel/Pictures/pexels-photo-11744.jpeg
