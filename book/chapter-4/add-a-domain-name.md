# Add a Domain Name (WIP)

The web app is now running, but most people will give you a strange look if you ask them to visit `52.201.208.126` or `http://ec2-52-201-208-126.compute-1.amazonaws.com`. We'll now make the web app reachable from a custom domain name. You will register a domain name, configure its name servers, and add DNS records associating the domain name with the web app's IP address.

## Prerequisits

* [The Domain Name System](../chapter-1/the-domain-name-system.md)

## Register a Domain Name

1. Navigate to the AWS Web Console's Route 53 dashboard.

2. Search for a domain name you like that is available and select it.

3. Enter your contact information. This is an [ICANN requirement](https://www.icann.org/resources/pages/registrant-contact-information-wdrp-2017-08-31-en).

4. Complete the purchase. I'm the proud owner of `novelcat.com`.

## Configure Name Servers

If you followed the steps to register a domain name with Route 53, you're done. AWS automatically creates a Hosted Zone for the domain name where you can configure DNS records.

If you registered your domain name with another registrar, you have to manually create a Route 53 Hosted Zone, then update the domain's name servers from your registrar's dashboard.

1. From the Route 53 dashboard create a new Hosted Zone for your Domain Name (`novelcat.com` in my case).

2. Select the Hosted Zone you created and take note of the 4 nameservers listed. For me, these are:

  ```
  ns-715.awsdns-25.net
  ns-1560.awsdns-03.co.uk
  ns-1281.awsdns-32.org
  ns-119.awsdns-14.com
  ```

3. View the Hosted Zone's Record Set, particularly the record of type SOA.

4. Log into your registrar's dashboard and search for an option to configure your domain's nameservers. Enter your Hosted Zone's four nameservers in order. Save.

5. Run the terminal command `dig <YOUR_DOMAIN>`. The SOA record reported should match the Route 53 dashboard. If not, wait a while for DNS updates to propagate through the internet, then try running dig again.

## Configure DNS Records

Now we create two DNS records. The first is an A record that maps your domain name to your server's IP address. The second is a CNAME that states the www subdomain is resolved by looking up the root domain name.

1. From the Route 53 dashboard navigate to the Record Set for your domain's Hosted Zone.

2. Create a new record set. Set **Name** to `<YOUR_DOMAIN>` by leaving the input field empty, set **Type** to *A*, set **Value** to your instance's IP address, and leave **TTL** alone. My record is below:

Name              | Type  | Value          | TTL
------------------|-------|----------------|----
novelcat.com.     | A     | 52.201.208.126 | 300

3. Create a new record set. Set **Name** to `www.<YOUR_DOMAIN>` by by setting the input field to `www`, set **Type** to *CNAME*, set **Value** to `<YOUR_DOMAIN>`, and leave **TTL** alone.   My record is below:

Name              | Type  | Value          | TTL
------------------|-------|----------------|----
www.novelcat.com. | CNAME | novelcat.com   | 300

4. Your web app should now be accessible at your domain name. Confirm this by navigating to the domain in your web browser. If not, wait a while for DNS changes to propagate through the internet. You can now SSH into your instance using your domain name. For example, I run `ssh -i ~/.ssh/aws.pem ubuntu@novelcat.com`.

## Redirect the www subdomain

Currently, your website is accessible through both the root domain and the www subdomain. To establish a single canonical source of content, redirect traffic targeting the www subdomain to the root domain.

1. Permanently redirect requests targeting `www.<YOUR_DOMAIN>` to `<YOUR_DOMAIN>` by replacing the content of `/etc/nginx/sites-enabled/default` with the following:

  ```
  server {
      listen 80;
      server_name <YOUR_DOMAIN>;
      location / {
        proxy_pass        http://127.0.0.1:3000;
        proxy_set_header  Host       $http_host;
        proxy_set_header  X-Real-IP  $remote_addr;
      }
    }
  server {
      server_name www.<YOUR_DOMAIN>;
      return 301 $scheme://<YOUR_DOMAIN>$request_uri;
  }
  ```

2. Restart ngingx with `sudo systemctl reload nginx`. From your web browser, navigate to `www.<YOUR_DOMAIN>` and confirm that you are redirected to `<YOUR_DOMAIN>`.

## References

1. https://www.digitalocean.com/community/tutorials/an-introduction-to-digitalocean-dns
2. https://www.digitalocean.com/community/tutorials/how-to-redirect-www-to-non-www-with-nginx-on-centos-7
