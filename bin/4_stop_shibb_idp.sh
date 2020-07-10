#!/bin/sh

IDP_CONTAINER=rt_shibb_idp

docker stop ${IDP_CONTAINER}
docker rm ${IDP_CONTAINER}
