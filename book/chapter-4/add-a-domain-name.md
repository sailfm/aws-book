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

2. Select the hosted zone you created and take note of the 4 nameservers listed. For me, these are:

  ```
  ns-715.awsdns-25.net
  ns-1560.awsdns-03.co.uk
  ns-1281.awsdns-32.org
  ns-119.awsdns-14.com
  ```

3. View the Hozed Zone's Record Sets, particularly the record of type SOA.

4. Log into your registrar's dashboard and search for an option to configure your domain's nameservers. Enter your Hosted Zone's four nameservers in order. Save.

5. Run the terminal command `dig <YOUR_DOMAIN>`. The SOA record reported should match the Route 53 dashboard. If not, wait a while for DNS updates to propagate through the internet, then try running dig again.

## Configure DNS Records



## Alternative Domain Name Registrars

* [Namecheap](https://www.namecheap.com/)
* [Gandi.net](https://www.gandi.net/)
* [Google Domains](https://domains.google/)

## Alternative DNS Management Providers

* [Cloudflare](https://www.cloudflare.com/)
* [Digital Ocean](https://www.digitalocean.com/)
* [Netlify](https://www.netlify.com/)
* [Google Cloud DNS](https://cloud.google.com/dns/docs/)
* Your domain registrar

## References

1. https://www.digitalocean.com/community/tutorials/an-introduction-to-digitalocean-dns
2. 