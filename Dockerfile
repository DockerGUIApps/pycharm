FROM debian

LABEL maintainer "Sergei O. Udalov <sergei.udalov@gmail.com>"

RUN apt-get update && apt-get install --no-install-recommends -y \
  python python-dev python-setuptools python-pip \
  python3 python3-dev python3-setuptools python3-pip \
  gcc git openssh-client curl \
  libxtst-dev libxext-dev libxrender-dev libfreetype6-dev \
  libfontconfig1 \
  && rm -rf /var/lib/apt/lists/*

ARG pycharm_source=https://download.jetbrains.com/python/pycharm-community-2018.3.1.tar.gz
ARG pycharm_local_dir=.PyCharmCE2018.3

WORKDIR /opt/pycharm

RUN curl -fsSL $pycharm_source -o /opt/pycharm/installer.tgz \
  && tar --strip-components=1 -xzf installer.tgz \
  && rm installer.tgz \
  && /usr/bin/python2 /opt/pycharm/helpers/pydev/setup_cython.py build_ext --inplace \
  && /usr/bin/python3 /opt/pycharm/helpers/pydev/setup_cython.py build_ext --inplace


RUN mkdir /root/.PyCharm \
  && ln -sf /root/.PyCharm /root/$pycharm_local_dir

CMD [ "/opt/pycharm/bin/pycharm.sh" ]
