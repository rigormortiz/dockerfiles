FROM rigormortiz/archlinuxarm-rpi-base:latest
LABEL maintainer Mike Ortiz <mike@jellydice.com>

COPY run_vnc.sh /run_vnc.sh

RUN pacman -Sy && \
    pacman -S --noconfirm tigervnc

EXPOSE 5901

ENTRYPOINT ["/run_vnc.sh"]
