#!/bin/sh

/usr/bin/getfacl -R ${1} > ${1}/permissions.facl