FROM openjdk:jre

RUN sed -i "s/httpredir.debian.org/`curl -s -D - http://httpredir.debian.org/demo/debian/ | awk '/^Link:/ { print $2 }' | sed -e 's@<http://\(.*\)/debian/>;@\1@g'`/" /etc/apt/sources.list \
    && printf "deb http://www.deb-multimedia.org jessie main non-free\ndeb-src http://www.deb-multimedia.org jessie main non-free\n" >> /etc/apt/sources.list \
    && apt-get update && apt-get install -y --force-yes deb-multimedia-keyring \
    && apt-get update && apt-get install -y --force-yes --no-install-recommends --fix-missing \
        imagemagick \
        build-essential libmp3lame-dev libvorbis-dev libtheora-dev libspeex-dev yasm pkg-config libfaac-dev libopenjpeg-dev libx264-dev \
        libopencore-amrnb-dev libopencore-amrwb-dev libx11-dev libxfixes-dev libxvidcore-dev zlib1g-dev libavcodec-dev libsdl1.2-dev texi2html \
        nasm \
        dcraw ufraw \
        gpac \
        libimage-exiftool-perl perl-doc \
        git-core checkinstall \
        libvpx-dev \
    && apt-get autoremove -y \
    && apt-get clean all \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/exiftool /usr/local/bin/exiftool

# Install FFMpeg
RUN cd /opt \
    && curl -sL "http://ffmpeg.org/releases/ffmpeg-2.7.2.tar.bz2" | tar -xvj \
    && cd ffmpeg-2.7.2 \
    && ./configure --enable-gpl --enable-version3 --enable-nonfree --enable-postproc \
    --enable-libfaac --enable-libopencore-amrnb --enable-libopencore-amrwb \
    --enable-libtheora --enable-libvorbis --enable-libx264 --enable-libxvid \
    --enable-x11grab --enable-libvpx --enable-libmp3lame \
    && make \
    && make install

# Install Razuna
RUN cd /opt \
    && curl -sL "http://razuna.org/razuna-tomcat.cfm?v=1.8.6" > razuna.zip \
    && unzip razuna.zip \
    && mv razuna_tomcat_1_8_6 razuna

EXPOSE 8080

WORKDIR /opt/razuna/tomcat/bin

CMD ["./catalina.sh", "run"]