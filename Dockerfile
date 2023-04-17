FROM drupal:9
# OS configuration
RUN apt-get update && apt-get install -y vim unzip wget default-mysql-client git sudo net-tools systemctl ufw nfs-common
RUN sudo apt-get upgrade -y
RUN sudo curl -o- https://raw.githubusercontent.com/vinyll/certbot-install/master/install.sh | bash

# Drupal configuration
COPY drupal/composer.json /opt/drupal
RUN cd /opt/drupal && wget -P "scripts/composer" -c "https://raw.githubusercontent.com/drupal-composer/drupal-project/9.x/scripts/composer/ScriptHandler.php"
RUN cd /opt/drupal && mkdir -p .composer/vendor/drupal/coder/coder_sniffer
RUN cd /opt/drupal && mkdir -p .composer/vendor/sirbrillig/phpcs-variable-analysis
RUN cd /opt/drupal && mkdir -p .composer/vendor/slevomat/coding-standard
RUN export PATH="$HOME/.composer/vendor/bin:$PATH"
RUN composer install
RUN composer require -n "drush/drush:*"