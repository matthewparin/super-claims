# super-claims

A BOSH-managed HBase deployment

## Run super-claims locally

### Install BOSH Lite

https://github.com/cloudfoundry/bosh-lite#install-bosh-lite

Alias the environment as "lite":

```
bosh alias-env lite -e 192.168.50.4 --ca-cert ca/certs/ca.crt
```

### Clone super-claims

```
cd ~/workspace
git clone git@github.com:lnhrdt/super-claims.git
```

### Upload claims-api release

```
cd ~/workspace/super-claims/releases/claims-api
./download_blobs.sh
bosh create-release
bosh -e lite upload-release
```

### Upload the stemcell

```
bosh -e lite upload-stemcell "https://bosh.io/d/stemcells/bosh-warden-boshlite-ubuntu-trusty-go_agent?v=3421.6"
```

### Deploy super-claims

```
cd ~/workspace/super-claims/manifests
bosh -e lite update-cloud-config cloud-lite.yml
bosh -e lite -d super-claims deploy manifest.yml
```

## Validating Services

### Kafka

Download the Kafka release to get access to the official testing tools:

```
cd ~/workspace
curl -L -o kafka_2.10-0.10.2.1.tgz "http://www.apache.org/dyn/closer.cgi?filename=kafka/0.10.2.1/kafka_2.10-0.10.2.1.tgz&action=download"
tar zxvf kafka_2.10-0.10.2.1.tgz
```

First terminal:

```
cd ~/workspace/kafka_2.10-0.10.2.1
./bin/kafka-console-producer.sh --broker-list 10.244.0.6:9092 --topic test
```

Second terminal:

```
cd ~/workspace/kafka_2.10-0.10.2.1
./bin/kafka-console-consumer.sh --bootstrap-server 10.244.0.7:9092 --topic test --from-beginning
```

Type a message in the first terminal and hit enter. You should see the message appear in the second terminal.

### HBase

- HBase Master Web UI: http://10.244.0.2:16010
