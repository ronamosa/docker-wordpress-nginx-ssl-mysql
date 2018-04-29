# Docker WordPress, NGINX+SSL, MySQL Database.

## Description
A quick example of dockerized wordpress setup with an NGINX reverse-proxy frontend doing the SSL termination, and a standard MySQL database backend.

## Pre-requisites
* docker installed locally
* docker-compose installed locally

## Setup
You'll need to do a few things to get this up & running on your local environment.

1. create your certs by going into 'certs/' and running `certs.sh`.
2. copy the `certs/whateveryoursiteis.cert` and `certs/whateveryoursiteis.key` to 'nginx/ssl/'.
3. run `docker-compose up` if you want to see all the start-up logs
4. or `docker-compose up -d` if you want to background.

## Setup Wordpress
As this was a local setup for me, the server_name of 'www.mywordpress.local' was just an entry in my local /etc/hosts.
```
127.0.0.1 www.mywordpress.local
```

* open a browser page to https://www.whateveryoursiteis.com and you should be greeted (if this is the first time running) with an page asking you to install wordpress.

## Key Points

this part in your default.conf:
```
        proxy_set_header      Host $host;
        proxy_set_header      X-Real-IP $remote_addr;
        proxy_set_header      X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header      X-Forwarded-Host $server_name;
        proxy_set_header      X-Forwarded-Proto https;

```
helps this part in your wp-config.php to work:
```
if (isset($_SERVER['HTTP_X_FORWARDED_PROTO']) && $_SERVER['HTTP_X_FORWARDED_PROTO'] === 'https') {
        $_SERVER['HTTPS'] = 'on';
}
```
this is where we're trying to force HTTPS at all times. The 301 redirect in default.conf for requests to port 80 also helps.

## Footnotes
obviously get some proper SSL certs for your own site, but this is a good miniature model of how the docker pieces fit together.
