# PLEASE READ

The intention of this work is to have a workable DevBox for local development, simplified and useful for our company development.
Please refer to Magento for latest updates.

** IF YOU WANT TO RUN MAGENTO1 CHECK TAG talosdigital/magento2devbox-web:php5.6 **

# Software requirements
1. Docker

# Installation
1. Prepare your project folder
```
mkdir -p myproject/shared
cd myproject
curl https://raw.githubusercontent.com/talosdigital/magento2devbox-web/master/docker-compose.yml > docker-compose.yml 
```

2. Modify keys for your project
```
#
# file: docker-compose.yml
#   replace `talosdevbox` with `YOUR_PROJECT_CODENAME`
#
```

3. Place your project files under `./shared/webroot`
```
# EXAMPLE: follow the next steps to create a Magento2 installation from scratch 
composer create-project --repository-url=https://repo.magento.com/ magento/project-community-edition ./shared/webroot
cd shared/webroot
php bin/magento sampledata:deploy
```

4. Start docker instances
Make sure you have 80, 3360, 4022 and 9000 available in your computer.
```
docker-compose up
```

5. Network alias to your docker machine (Mac)
```
sudo ifconfig lo0 alias 10.254.254.254 255.255.255.0 # Check bellow how to add it at startup
sudo vi /etc/hosts
10.254.254.254 db
10.254.254.254 local.magento2ce.com
```

6. Prepare database
```
mysql -h db -uroot -proot
CREATE DATABASE magento2ce;
```

7. Magento env.php file. Please use the following settings:
```
# Database Server Host: db
# Database Server Username: root
# Database Server Password: root
```

# Useful commands

Alias
```
# Useful aliases
alias mysqldocker='mysql -h 10.254.254.254 -uroot -proot'
alias sshdocker='ssh -p 4022 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no magento2@localhost'
alias dsyncin='rsync -rvtu -e "ssh -p 4022" --exclude="app"  --exclude=".git/" --exclude=".idea/" --exclude="generated/*" --exclude="var/*" --exclude="pub/static/*" . magento2@10.254.254.254:/var/www/magento2';
alias dsyncout='rsync -rvtu -e "ssh -p 4022" --exclude="app"  --exclude=".git/" --exclude=".idea/" --exclude="generated/*" --exclude="var/*" --exclude="pub/static/*" magento2@10.254.254.254:/var/www/magento2/* .';
```

Magento Bin
```
ssh -p 4022 magento2@localhost # FYI password: magento2
cd /var/www/magento2
php bin/magento cache:flush
```

List running containers
```docker ps```

List all containers
```docker ps```

# Alias loopback interface (lo0) script at startup (Mac)
```
sudo bash -c "curl https://raw.githubusercontent.com/talosdigital/magento2devbox-web/master/com.network.alias.plist > /Library/LaunchDaemons/com.network.alias.plist"
sudo chmod 0644 /Library/LaunchDaemons/com.network.alias.plist
sudo chown root:wheel /Library/LaunchDaemons/com.network.alias.plist
sudo launchctl load /Library/LaunchDaemons/com.network.alias.plist
```

# PHPSTORM xDebug setup (Mac)

![phpstorm1](https://raw.githubusercontent.com/talosdigital/magento2devbox-web/master/phpstorm1.png)
![phpstorm2](https://raw.githubusercontent.com/talosdigital/magento2devbox-web/master/phpstorm2.png)
![phpstorm3](https://raw.githubusercontent.com/talosdigital/magento2devbox-web/master/phpstorm3.png)

# Passwords
```MySQL: root root```

```Linux: magento2 magento2```
