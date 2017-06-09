#!/bin/bash

mkdir -p blobs/java8

(cd blobs/java8; curl -b "oraclelicense=accept-securebackup-cookie" -L -J -C - -O http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz)

