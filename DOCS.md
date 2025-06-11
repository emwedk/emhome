# Emhome Dockerized Home Assistant

Make sure to create a .passwd and secrets.yml file in users home directory

.passwd contains password of the system

secrets.yml contains
```bash
duckdns:
  token: <duckdns_doken>
  subdomains:
    - <domain1.duckdns.org>
    - <domain2.duckdns.org>
letsencrypt:
  email: <your_letsencrypt_email>
```