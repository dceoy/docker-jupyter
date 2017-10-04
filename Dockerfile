FROM jupyter/scipy-notebook

USER root

RUN set -e \
      && ln -s /usr/bin/perl /opt/conda/bin/perl \
      && ln -sf /bin/bash /bin/sh

RUN set -e \
      && apt-get -y update \
      && apt-get -y upgrade \
      && apt-get -y install apt-utils \
      && apt-get clean

USER ${NB_USER}

RUN set -e \
      && conda upgrade --all -y \
      && conda install -y biopython bokeh cython csvkit docopt fbprophet \
                          feather-format flake8 ggplot keras lightgbm luigi \
                          numpy pandas plotly psutil pymc pystan pytoml \
                          pyyaml scikit-learn scipy seaborn sphinx sympy \
                          tensorflow xgboost \
      && conda clean -tipsy \
      && fix-permissions $CONDA_DIR
