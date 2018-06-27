FROM ready2order/php:7.2.7-1

RUN apt-get update \
    && echo "Installing http stransport..." \
    && apt-get install -y apt-transport-https \
    && echo "Installing packages..." \
    && echo "mkdir: Needed due to bug: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=863199" \
    && mkdir -p /usr/share/man/man1 \
    && apt-get update && apt-get install -y \
            sudo build-essential lsb-release \
            ssh \
            dnsutils iputils-ping \
            gnupg2 \
            zsh \
            zip unzip gzip \
            curl wget \
            neovim nano \
            python python-pip python3 openjdk-8-jre-headless ca-certificates-java \
            git \
            percona-toolkit \
            redis-tools mysql-client \
     && apt-get clean \
     && echo "Setting default shell to zsh..." \
     && chsh -s /bin/zsh \
     && echo "Installing composer..." \
     && curl -L -sS https://getcomposer.org/installer | php \
     && mv composer.phar /usr/local/bin/composer \
     && echo "Installing phpunit" \
     && wget https://phar.phpunit.de/phpunit-7.phar \
     && chmod +x phpunit-7.phar \
     && mv phpunit-7.phar /usr/local/bin/phpunit \
     && echo "Installing node js..." \
     && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
     && apt-get install -y nodejs \
     && echo "Installing yarn..." \
     && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
     && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
     && apt-get update && apt-get install yarn \
     && echo "Installing google cloud tools..." \
     && export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" \
     && echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list \
     && curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - \
     && apt-get update && apt-get install -y google-cloud-sdk kubectl \
     && echo "Installing helm cli..." \
     && curl -L https://storage.googleapis.com/kubernetes-helm/helm-v2.8.2-linux-amd64.tar.gz | tar xvz \
     && mv linux-amd64/helm /usr/local/bin/ \
     && rm -r linux-amd64 \
     && echo "Installing aws cli..." \
     && pip install awscli
