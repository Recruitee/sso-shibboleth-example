#!/bin/sh

IDP_IMAGE_TAG="rt_shibb_idp"

LDAP_CONTAINER="rt_ldap"
IDP_CONTAINER="rt_shibb_idp"

IP_FMT='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
GATEWAY_FMT='{{range .NetworkSettings.Networks}}{{.Gateway}}{{end}}'

RT_LDAP_IP=`docker inspect -f "${IP_FMT}" ${LDAP_CONTAINER}`
if [ $? -eq 1 ];
then
  echo "LDAP Container not up"
  exit 1
fi

GATEWAY_IP=`docker inspect -f "${GATEWAY_FMT}" ${LDAP_CONTAINER}`

docker run -d \
  -p 443:4443 -p 8443:8443 \
  --name ${IDP_CONTAINER} \
  --add-host rt.howto:${GATEWAY_IP} \
  --add-host rt.ldap:${RT_LDAP_IP} \
  ${IDP_IMAGE_TAG}
