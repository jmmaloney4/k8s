FROM ubuntu:bionic
# apt-get -y install python-pip beets sudo openssh-client git git-lfs curl
RUN apt-get -y update && \
    apt-get -y install python3-pip beets git git-lfs sudo
RUN pip3 install requests

RUN useradd -ms /bin/bash beets && echo "beets:beets" | chpasswd && usermod -aG sudo beets
RUN chown -R beets /home/beets/ && mkdir /music && chown -R beets /music/

USER beets
WORKDIR /home/beets/

CMD sleep 3600