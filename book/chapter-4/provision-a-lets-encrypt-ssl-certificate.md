# Provision a Lets Encrypt SSL Certificate (WIP)



## Prerequisites

* [Web Security](../chapter-1/web-security.md)

## Concepts

* SSL Certificates
* Lets Encrypt Certificate Authority
* Web Browsers
* AWS certificate manager doesn't work for EC2 instances

## Steps

1. Open `/etc/nginx/sites-enabled/default` and change `server_name reader1;` to `server_name <YOUR_DOMAIN> www.<YOUR_DOMAIN>;`. I ran `server_name novelcat.com www.novelcat.com;`.

2. Restart ngingx with `sudo systemctl reload nginx` and confirm your web app is still available.

3. Install certbot on your instance by running the following commands.

  ```
  sudo add-apt-repository ppa:certbot/certbot
  sudo apt-get update
  sudo apt-get install python-certbot-nginx
  ```

4. Generate a LetsEncrypt SSL Certificate and automatically configure nginx to use it with `sudo certbot --nginx -d <YOUR_DOMAIN> -d www.<YOUR_DOMAIN>`. I ran `sudo certbot --nginx -d novelcat.com -d www.novelcat.com`. When prompted, enable redirects from http to https. certbot will automatically modify `/etc/nginx/sites-enabled/default` to support ssl and redirects, as follows:

  ```
  server {
      server_name novelcat.com;
      location / {
          proxy_pass        http://127.0.0.1:3000;
          proxy_set_header  Host       $http_host;
          proxy_set_header  X-Real-IP  $remote_addr;
      }
      listen 443 ssl;
      ssl_certificate /etc/letsencrypt/live/novelcat.com/fullchain.pem;
      ssl_certificate_key /etc/letsencrypt/live/novelcat.com/privkey.pem;
      include /etc/letsencrypt/options-ssl-nginx.conf;
      ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
  }
  server {
      server_name www.novelcat.com;
      return 301 $scheme://novelcat.com$request_uri;
      listen 443 ssl;
      ssl_certificate /etc/letsencrypt/live/novelcat.com/fullchain.pem;
      ssl_certificate_key /etc/letsencrypt/live/novelcat.com/privkey.pem;
      include /etc/letsencrypt/options-ssl-nginx.conf;
      ssl_dhparam /etc/letsencrypt/ssl-dhparams.pem;
  }
  server {
      if ($host = novelcat.com) {
          return 301 https://$host$request_uri;
      }
      listen 80;
      server_name novelcat.com;
      return 404;
  }
  server {
      if ($host = www.novelcat.com) {
          return 301 https://$host$request_uri;
      }
      server_name www.novelcat.com;
      listen 80;
      return 404;
  }
  ```

5. From your web browser, navigate to your web app and verify that your connection is secure and that all protocol and hostname combinations redirect corrrectly. For me, `http://www.novelcat.com`, `https://www.novelcat.com` and `https//novelcat.com` all redirect to `https://novelcat.com`.

## References 

1. https://certbot.eff.org/lets-encrypt/ubuntuxenial-nginx
