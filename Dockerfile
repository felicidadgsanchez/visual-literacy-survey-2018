# Use an official Jupyter image
# We are using scipy-notebook since we need only data science capabilities in Python
# We use the version #7f1482f5a136 as it is the latest in March 2019
FROM jupyter/scipy-notebook:7f1482f5a136

LABEL maintainer="Juan Cruz-Benito <cruzbenitojuan@gmail.com>"

USER $NB_UID

# Creating the directory datasets/ in the /home/user if it does not exist previously
RUN mkdir -p /home/$NB_USER/datasets
# Adding the datasets (csv files) included in this repository to the datasets folder 
# in the Docker image.
COPY datasets/* /home/$NB_USER/datasets/
# Creating the directory fonts/ in the /home/user if it does not exist previously
RUN mkdir -p /home/$NB_USER/fonts
# Adding the fonts included in this repository to the fonts folder in the Docker image.
COPY fonts/* /home/$NB_USER/fonts/
# Adding the backup of the notebooks included in this repository to the home directory
# in the Docker image.
COPY notebooks/* /home/$NB_USER/

# Install all libraries and tools to use:cufflinks-py
RUN conda install spacy nltk gensim plotly colorlover autopep8 jupyter_contrib_nbextensions && \
    python -m spacy download en && \
    python -m spacy download fr && \
    python -m spacy download es && \
    pip install nbimporter && \
    pip install plotly_express && \
    pip install langdetect && \
    pip install wordcloud && \
    conda clean -tipsy

# Activate Jupyter extensions: Hinterland & autopep8
RUN jupyter contrib nbextension install --sys-prefix && \
    jupyter nbextension enable hinterland/hinterland --sys-prefix && \
    jupyter nbextension enable code_prettify/autopep8 --sys-prefix

RUN rmdir /home/$NB_USER/work

USER root
RUN fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER
USER $NB_UID

# Switch back to jovyan to avoid accidental container runs as root
USER $NB_UID