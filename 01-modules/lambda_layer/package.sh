#!/bin/sh

ARCHIVE_PATH=$1
RUNTIME=$2
PLATFORM=$3

rm -rf $ARCHIVE_PATH

docker run --rm \
  --user $UID:$UID \
  -v $(pwd):/var/task \
  public.ecr.aws/sam/build-$RUNTIME /bin/sh -c "pip install -r requirements.txt \
  --platform $PLATFORM\
  --only-binary=:all: \
  -t $ARCHIVE_PATH/python; exit"
