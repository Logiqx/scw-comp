# Project Env
. $(dirname $0)/env.sh

# Determine Tag
IMAGE_NAME=$PROJ_NAME
IMAGE_TAG=tmp

# Docker Build
DOCKER_BUILDKIT=1 docker build . --file Dockerfile --build-arg LOGIQX_DEBUG -t $IMAGE_NAME:$IMAGE_TAG

# Copy the library scripts
docker run --rm --entrypoint cat scw-comp:tmp $WORK_DIR/python/Common_Functions.py >$PROJ_DIR/python/Common_Functions.py

# Clear pycache
rm $PROJ_DIR/python/__pycache__/Common_Functions.*.pyc
