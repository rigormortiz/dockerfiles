FROM rigormortiz/alpine-armhf:latest AS prep
LABEL maintainer "Mike Ortiz <mike@jellydice.com>"

ENV VERSION="2018.06"
ENV ROOTFS_ARCHIVE="http://il.us.mirror.archlinuxarm.org/os/rpi/ArchLinuxARM-${VERSION}-rpi-2-rootfs.tar.gz"

# Was going to also check sig, but as long as the hash matches up
# to what is in this Dockerfile, pacman will validate PGP sigs for packages in the setup stage
ENV ROOTFS_MD5_HASH="23f988125e280ec275d3447001b67c9a"
 
ADD ${ROOTFS_ARCHIVE} /arch/rootfs.tar.gz

RUN apk add --no-cache --virtual libarchive-tools outils-md5 && \
    LOCAL_MD5_HASH=$(md5sum /arch/rootfs.tar.gz | awk '{print $1}') && \
    if [[ "${LOCAL_MD5_HASH}" != "${ROOTFS_MD5_HASH}" ]]; then exit 1; fi && \
    cd arch && \
    bsdtar -xpf rootfs.tar.gz && \
    rm rootfs.tar.gz

# Setup Stage
FROM scratch AS setup
LABEL maintainer Mike Ortiz <mike@jellydice.com>

COPY --from=prep /arch/ /

RUN echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen && \
    #echo 'Server = https://mirrors.kernel.org/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist && \
    pacman-key --init && \
    pacman-key --populate archlinuxarm && \
    pacman -Rs --noconfirm device-mapper systemd crda \
        cryptsetup dhcpcd lvm2 mkinitcpio netctl \
        systemd-sysvcompat linux-raspberrypi && \
    pacman -Syu --noconfirm && \
    pacman -Scc --noconfirm && \
    rm -rf /usr/share/man/* /usr/share/doc/*


# Final Stage - mainly to flatten
FROM scratch
LABEL maintainer Mike Ortiz <mike@jellydice.com>

COPY --from=setup / /

# Since we are a base image we could be nice to people building in other regions. Also, I like HTTPS!
# But... this takes a while so it is only useful for building intermediate base images (e.g., a language base or similar)
# Uncomment if this would be helpful
# ONBUILD RUN curl -s "https://www.archlinux.org/mirrorlist/?protocol=https&use_mirror_status=on" | sed -e 's/^#Server/Server/' -e '/^#/d' | rankmirrors -n 5 - && \
#            pacman -Rs -noconfirm pacman-contrib
