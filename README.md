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

### Upload HBase release

```
cd ~/workspace/super-claims/releases/hbase
./download_blobs.sh
bosh create-release
bosh -e lite upload-release
```

### Upload the stemcell

```
cd ~/workspace/super-claims/manifests
./download_stemcell.sh
bosh -e lite upload-stemcell bosh-stemcell-*
```

### Deploy super-claims

```
cd ~/workspace/super-claims/manifests
bosh -e lite update-cloud-config cloud-lite.yml
bosh -e lite -d super-claims deploy manifest.yml
```

## Web UIs

- HBase Master: http://10.244.0.2:16010
