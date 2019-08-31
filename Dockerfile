# Based on https://github.com/mikedickey/RoonServer
FROM debian:stretch-slim

RUN apt-get update \
	&& apt-get install -y ffmpeg libav-tools curl bzip2 cifs-utils libasound2 \
	&& apt-get -y clean && apt-get -y autoclean

ENV ROON_DATAROOT=/var/roon/
ENV ROON_ID_DIR /var/roon/

# Location of Roon's latest Linux installer
ENV ROON_INSTALLER roonserver-installer-linuxx64.sh
ENV ROON_INSTALLER_URL http://download.roonlabs.com/builds/${ROON_INSTALLER}

# Grab installer and script to run it
ADD ${ROON_INSTALLER_URL} /tmp
RUN chmod +x /tmp/${ROON_INSTALLER}

# Run the installer, answer "yes" and ignore errors
RUN printf "y\ny\n" | /tmp/${ROON_INSTALLER} >> /tmp/roon_installer.log 2>&1

# Your Roon data will be stored in /var/roon; /music is for your music
VOLUME [ "/var/roon", "/music" ]

# This starts Roon when the container runs
ENTRYPOINT /opt/RoonServer/start.sh