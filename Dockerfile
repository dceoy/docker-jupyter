FROM jupyter/scipy-notebook:latest

USER root

RUN set -e \
      && ln -s /usr/bin/perl /opt/conda/bin/perl \
      && ln -sf /bin/bash /bin/sh

RUN set -e \
      && apt-get -y update \
      && apt-get -y upgrade \
      && apt-get -y install --no-install-recommends --no-install-suggests apt-utils \
      && apt-get -y autoremove \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

USER ${NB_USER}

RUN set -e \
      && conda update -y -n base conda \
      && conda update --all -y \
      && conda install -y airflow biopython bokeh cython csvkit docopt fbprophet feather-format \
                          flake8 ggplot jupyter_contrib_nbextensions jupyterthemes keras lightgbm \
                          luigi matplotlib numpy pandas plotly psutil pymc pystan pytoml pyyaml \
                          redis scikit-learn scipy seaborn sphinx sympy tensorflow tornado \
                          xgboost xmltodict \
      && conda clean -tipsy \
      && fix-permissions ${CONDA_DIR} \
      && fix-permissions /home/${NB_USER}

RUN set -e \
      && jupyter contrib nbextension install --user \
      && jt --theme oceans16 --toolbar --nbname --vimext