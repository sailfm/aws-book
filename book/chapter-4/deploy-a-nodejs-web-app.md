# Install and Run a NodeJS Web App (WIP)

Now we'll run a simple web app, the readability proxy, on the virtual machine. On the web app's homepage, users enter a URL and submit it to the server. The server fetches the HTML document at the URL, extracts the article text, then finally returns an HTML page containing only the article text to the user's web browser. Note that there is no persistent data, no caching, and only one server that handles all requests.

## Prerequisites

* [Web App Architecture](../chapter-1/web-app-architecture.md)
* [Web Developer Tools](../chapter-1/web-developer-tools.md)

## Concepts

## Steps

1. Open your terminal and ssh into your virtual machine with the command `ssh -i <PRIVATE_KEY_FILE> ubuntu@<VM_PUBLIC_HOSTNAME>`. In my case, this is `ssh -i ~/.ssh/aws.pem ubuntu@ec2-52-201-208-126.compute-1.amazonaws.com`.

2. Start a screen session by running `screen`. This ensures that commands will run even if your terminal session is disrupted. 
    
    > Run `screen -ls` to list running screen sessions, `screen -r <SESSION_NUMBER>` to attach a screen session, `screen -d <SESSION_NUMBER>` to detach a screen session, `ctrl-a, ctrl-d` to detatch the current screen session, and `exit` to terminate the current screen session.

3. Update and install instance software:

  ```sh
  # update system software
  sudo apt upgrade
  # install nodejs
  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
  sudo apt install -y nodejs
  sudo apt install -y build-essential
  # install nginx
  sudo apt install -y nginx
  # install pm2
  sudo npm install pm2@latest -g
  ```

  <!-- ```sh
  # update system software
  sudo yum update
  # install git
  sudo yum install git
  # install nodejs
  curl --silent --location https://rpm.nodesource.com/setup_8.x | sudo bash -
  sudo yum -y install nodejs
  sudo yum install gcc-c++ make
  # install pm2
  sudo npm install pm2@latest -g
  # install nginx
  sudo yum install epel-release
  sudo yum install nginx
  ``` -->

4. Install and start the web app in development mode:

  ```sh
  git clone https://github.com/sailfm/reader1
  cd reader1
  npm install
  npm start
  ```

5. Confirm your web app is running by detaching from the screen session with `ctrl-a, ctrl-d` and running `curl localhost:3000`. You should see the web app's HTML home page.

6. Reattach to the screen session by identifying the detached session number with `screen -ls` then attach to the session with `screen -r <SESSION_NUMBER>`. Stop the web app with `ctrl-c`.

7. Configure the node process manager pm2 to resume saved processes when the machine restarts by running the command suggested when you run `pm2 startup`.

8. Start the web app with pm2 by running `npm run production`. Ensure it works with `curl localhost:3000`. Save the running processes with `pm2 save`.

  ```
  pm2 status - view state of running processes
  pm2 save - saves running processes so pm2 can restore them
  pm2 delete <ID> - kills the process with the given ID (run pm2 status to discover ID)
  pm2 resurrect - restore saved processes
  ```

9. Configure nginx to reverse proxy your web app by replace the contents of `/etc/nginx/sites-enabled/default` with the following:

  ```
  server {
    listen 80;
    server_name reader1;
    location / {
      proxy_pass        http://127.0.0.1:3000;
      proxy_set_header  Host       $http_host;
      proxy_set_header  X-Real-IP  $remote_addr;
    }
  }
  ```

<!-- 9. Open the ngingx config file with `sudo nano /etc/nginx/nginx.conf`, search for "location" and replace the empty block with the following:

  ```
    location / {
        proxy_pass http://127.0.0.1:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
  ``` -->

10. Restart nginx with `sudo service nginx restart`.

<!-- 11. Run ``sudo systemctl enable nginx`` to start nginx on boot. If this command fails, try `sudo systemctl enable nginx`. -->

11. The web app is now running an publicly available. Access it from your web browser. In my case, I navigated to `http://ec2-52-201-208-126.compute-1.amazonaws.com`.

12. Restart the instance with `sudo shutdown -r now`, then confirm the web app automatically becomes reachable again.

## References

1. https://nodejs.org/en/docs/guides/
2. https://hapijs.com/
3. https://github.com/sailfm/reader1
4. https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/install-updates.html
5. https://www.digitalocean.com/community/tutorials/how-to-set-up-a-node-js-application-for-production-on-centos-7
6. https://medium.com/@nishankjaintdk/setting-up-a-node-js-app-on-a-linux-ami-on-an-aws-ec2-instance-with-nginx-59cbc1bcc68c