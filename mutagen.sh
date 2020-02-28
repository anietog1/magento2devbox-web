#!/bin/bash
mutagen create \
       --sync-mode=two-way-resolved \
       --default-owner-beta=magento2 \
       --default-group-beta=magento2 \
       --default-file-mode=0644 \
       --default-directory-mode=0755 \
       --ignore=/.idea \
       --ignore=/.magento \
       --ignore=/.docker \
       --ignore=/.github \
       --ignore=/pub/static/* \
       --ignore=!/pub/static/.htaccess \
       --ignore=/pub/media/catalog/product/cache \
       --ignore=/var/view_preprocessed \
       --ignore=/var/page_cache \
       --ignore=/var/cache \
       --ignore=/var/session \
       --ignore=/var/composer_home \
       --ignore=/var/docker \
       --ignore-vcs \
       --symlink-mode=posix-raw \
       ./ docker://$(docker ps | grep web | awk "{print \$1}")/var/www/magento2
