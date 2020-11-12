FROM jupyter/minimal-notebook:latest

ARG conda_env=python39
ARG py_ver=3.9

RUN conda create --quiet --yes -p $CONDA_DIR/envs/$conda_env python=$py_ver ipython ipykernel ipywidgets && \
    conda clean --all -f -y

RUN $CONDA_DIR/envs/${conda_env}/bin/python -m ipykernel install --user --name=${conda_env} && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

ENV PATH $CONDA_DIR/envs/${conda_env}/bin:$PATH
ENV CONDA_DEFAULT_ENV ${conda_env}
