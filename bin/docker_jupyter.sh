PROJ_DIR=$(realpath $(dirname $0)/..)
PROJ_NAME=$(basename $PROJ_DIR)
WORK_DIR=/home/jovyan/work/$PROJ_NAME


set -ex
cd $PROJ_DIR

## if this fails you need to install jupyter first: docker pull jupyter/base-notebook
docker run -it -p 8888:8888 -v "$(pwd)":/home/jovyan/work jupyter/base-notebook
