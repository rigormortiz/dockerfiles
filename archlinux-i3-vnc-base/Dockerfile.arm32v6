FROM rigormortiz/archlinux-vnc:latest
LABEL maintainer Mike Ortiz <mike@jellydice.com>

RUN pacman -Sy && \
    pacman -S --noconfirm i3-gaps xterm dmenu xorg-fonts-misc

COPY xstartup /etc/skel/.vnc/xstartup

