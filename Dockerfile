FROM python:slim

RUN set -e \
      && ln -sf /bin/bash /bin/sh

RUN set -e \
      && apt-get -y update \
      && apt-get -y dist-upgrade \
      && apt-get -y autoremove \
      && apt-get -y install --no-install-recommends --no-install-suggests \
        curl gcc libc-dev locales p7zip-full pandoc pbzip2 pigz \
        texlive-fonts-recommended texlive-generic-recommended texlive-xetex \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

RUN set -e \
      && locale-gen en_US.UTF-8 \
      && update-locale

RUN set -e \
      && pip install -U --no-cache-dir numpy \
      && pip install -U --no-cache-dir \
        autopep8 bash_kernel cython feather-format flake8 ggplot jupyter \
        jupyter_contrib_nbextensions jupyterthemes lightgbm matplotlib \
        pandas pandas-datareader pip psutil pystan scikit-learn scipy \
        seaborn sklearn-pandas statsmodels tqdm xgboost

ENV HOME /home/notebook

RUN set -e \
      && mkdir ${HOME} \
      && python -m bash_kernel.install \
      && jupyter contrib nbextension install --system \
      && jt --theme oceans16 -f ubuntu --toolbar --nbname --vimext \
      && find ${HOME} -exec chmod 777 {} \;

EXPOSE 8888

ENTRYPOINT ["jupyter"]
CMD ["notebook", "--port=8888", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
