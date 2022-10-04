FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

ADD https://bootstrap.pypa.io/get-pip.py /tmp/get-pip.py

RUN set -e \
      && ln -sf bash /bin/sh \
      && ln -s python3 /usr/bin/python

RUN set -e \
      && apt-get -y update \
      && apt-get -y dist-upgrade \
      && apt-get -y install --no-install-recommends --no-install-suggests \
        apt-transport-https apt-utils ca-certificates curl g++ gcc locales \
        p7zip-full pandoc pbzip2 pigz python3-dev python3-distutils \
        texlive-fonts-recommended texlive-plain-generic texlive-xetex \
      && apt-get -y autoremove \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

RUN set -e \
      && locale-gen en_US.UTF-8 \
      && update-locale

RUN set -e \
      && /usr/bin/python3 /tmp/get-pip.py \
      && pip install -U --no-cache-dir cython numpy pip \
      && pip install -U --no-cache-dir \
        autopep8 bash_kernel feather-format flake8 flake8-bugbear \
        flake8-isort ggplot jupyter jupyter_contrib_nbextensions \
        jupyterthemes lightgbm matplotlib pandas pandas-datareader \
        pep8-naming psutil pystan scikit-learn scipy seaborn \
        sklearn-pandas statsmodels tqdm xgboost

ENV HOME /home/notebook

RUN set -e \
      && mkdir ${HOME} \
      && /usr/bin/python3 -m bash_kernel.install \
      && jupyter contrib nbextension install --system \
      && jt --theme oceans16 -f ubuntu --toolbar --nbname --vimext \
      && find ${HOME} -exec chmod 777 {} \;

EXPOSE 8888

ENTRYPOINT ["/usr/local/bin/jupyter"]
CMD ["notebook", "--port=8888", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
