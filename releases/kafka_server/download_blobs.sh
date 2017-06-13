#!/bin/bash

mkdir -p blobs/jdk blobs/kafka

(cd blobs/jdk; curl -b "oraclelicense=accept-securebackup-cookie" -L -J -C - -O http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz)

(cd blobs/kafka; curl -L -o kafka_2.10-0.10.2.1.tgz "http://www.apache.org/dyn/closer.cgi?filename=kafka/0.10.2.1/kafka_2.10-0.10.2.1.tgz&action=download")
