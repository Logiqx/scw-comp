# Base image versions
ARG NOTEBOOK_VERSION=notebook-6.2.0
ARG PYTHON_VERSION=3.9
ARG ALPINE_VERSION=3.13

# Jupyter notebook image is used as the builder
FROM jupyter/base-notebook:${NOTEBOOK_VERSION} AS builder

# Copy the required project files
WORKDIR /home/jovyan/work/scw-comp
COPY --chown=jovyan:users python/*.*py* ./python/

# Convert Jupyter notebooks to regular Python scripts
RUN jupyter nbconvert --to python python/*.ipynb && \
    rm python/*.ipynb

# Ensure project file permissions are correct
RUN chmod 755 python/*.py

# Create final image from Python 3 + Beautiful Soup 4 on Alpine Linux
FROM logiqx/python-lev:${PYTHON_VERSION}-alpine${ALPINE_VERSION}

# Note: Jovian is a fictional native inhabitant of the planet Jupiter
ARG PY_USER=jovyan
ARG PY_GROUP=jovyan
ARG PY_UID=1000
ARG PY_GID=1000

# Create the Python user and work directory
RUN addgroup -g ${PY_GID} ${PY_GROUP} && \
    adduser -u ${PY_UID} --disabled-password ${PY_USER} -G ${PY_GROUP} && \
    mkdir -p /home/${PY_USER}/work && \
    chown -R ${PY_USER} /home/${PY_USER}

# Install Tini
RUN apk add --no-cache tini=~0.19

# Install Python libraries
RUN pip install --no-cache-dir xlrd==1.2.*

# Copy project files from the builder
USER ${PY_USER}
WORKDIR /home/${PY_USER}/work/scw-comp
COPY --from=builder --chown=jovyan:jovyan /home/jovyan/work/scw-comp/ ./
RUN mkdir data docs

# Wait for CMD to exit, reap zombies and perform signal forwarding
ENTRYPOINT ["/sbin/tini", "--"]
CMD ["python"]
