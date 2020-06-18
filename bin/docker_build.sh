# Project Env
. $(dirname $0)/env.sh

# Determine Tag
IMAGE_NAME=$PROJ_NAME
IMAGE_TAG=$(git rev-parse --short=12 HEAD)

# Docker Build
DOCKER_BUILDKIT=1 docker build . --file Dockerfile --build-arg LOGIQX_DEBUG -t $IMAGE_NAME:$IMAGE_TAG

# Refresh Scrambles
run_py_script Weekly_Scrambles.py

# Convert Spreadsheets
run_py_script Convert_Spreadsheets.py

# Refresh Results
run_py_script Weekly_Results.py

# Docker Tag
docker tag $IMAGE_NAME:$IMAGE_TAG $IMAGE_NAME:latest
