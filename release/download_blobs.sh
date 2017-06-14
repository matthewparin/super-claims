#!/bin/bash

set -e

mkdir -p blobs/oraclejdk8 blobs/hbase blobs/kafka

(cd blobs/oraclejdk8; curl -b "oraclelicense=accept-securebackup-cookie" -L -J -C - -O http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz)

(cd blobs/hbase; curl -L -o hbase-1.2.6-bin.tar.gz "http://www.apache.org/dyn/closer.cgi?filename=hbase/1.2.6/hbase-1.2.6-bin.tar.gz&action=download")

(cd blobs/kafka; curl -L -o kafka_2.10-0.10.2.1.tgz "http://www.apache.org/dyn/closer.cgi?filename=kafka/0.10.2.1/kafka_2.10-0.10.2.1.tgz&action=download")
