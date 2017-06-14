# super-claims

A BOSH-managed HBase deployment

## Run super-claims locally

### Setup your workstation

```
brew install cloudfoundry/tap/bosh-cli
ln -s /usr/local/bin/bosh2 /usr/local/bin/bosh
brew cask install vagrant
brew cask install virtualbox
mkdir -p ~/workspace
cd ~/workspace
git clone https://github.com/cloudfoundry/bosh-lite
git clone git@github.com:lnhrdt/super-claims.git
```

### Every time you restart your computer

```
cd ~/workspace/bosh-lite
vagrant up --provider=virtualbox
bosh alias-env lite -e 192.168.50.4 --ca-cert ca/certs/ca.crt
bin/add-route
```

Login to BOSH Lite using username: `admin` and password: `admin`:

```
bosh -e lite login
```

### Upload claims-api release

```
cd ~/workspace/super-claims/release
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
cd ~/workspace/super-claims/deployment
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

### Kafka Zookeeper

Open a connection to Zookeeper:

```
telnet 10.244.0.3 2181
```

Type `stats` and press enter.

### HBase

- HBase Master Web UI: http://10.244.0.2:16010

### HBase Zookeeper

Open a connection to Zookeeper:

```
telnet 10.244.0.2 2181
```

Type `stats` and press enter.
