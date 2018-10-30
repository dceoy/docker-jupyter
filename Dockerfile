FROM python:slim

RUN set -e \
      && ln -sf /bin/bash /bin/sh

RUN set -e \
      && apt-get -y update \
      && apt-get -y dist-upgrade \
      && apt-get -y autoremove \
      && apt-get -y install --no-install-recommends --no-install-suggests \
        gcc libc-dev p7zip-full pbzip2 pigz \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

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
      && jt --theme oceans16 --toolbar --nbname --vimext \
      && find ${HOME} -exec chmod 777 {} \;

EXPOSE 8888

ENTRYPOINT ["jupyter"]
CMD ["notebook", "--port=8888", "--ip=0.0.0.0", "--allow-root", "--no-browser"]
