#!/usr/bin/env bash
sudo openssl req -new > my_wpress_site.csr
sudo openssl rsa -in privkey.pem -out my_wpress_site.key
sudo openssl x509 -in my_wpress_site.csr -out my_wpress_site.cert -req -signkey my_wpress_site.key -days 360
