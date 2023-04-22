# alpinevms-light
Minimal server and helm chart 

## installation
```sh
helm repo add hkms https://herokukms.github.io/alpinevms-light/
helm repo update
helm install hkms hkms/alpinevms-light
```
with different port
```sh
helm install hkms hkms/alpinevms-light --set kms.port=50000
```