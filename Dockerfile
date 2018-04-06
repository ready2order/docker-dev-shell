FROM base/archlinux

RUN echo "Updating packages..." \
    && pacman -Syu --noconfirm \
    && echo "Installing packages..." \
    && pacman -S --needed --noconfirm \
            base-devel \
            zsh \
            zip unzip gzip \
            curl wget \
            vim \
            python python2 jdk8-openjdk \
            php \
            ripgrep fd \
            git \
            aws-cli \
            percona-toolkit \
            redis mariadb-clients \
     && pacman -Sc --noconfirm \
     && echo "Setting default shell to zsh..." \
     && chsh -s /bin/zsh \
     && echo "Installing google cloud tools..." \
     && curl -L https://sdk.cloud.google.com > /tmp/gcloud.sh \
     && chmod +x /tmp/gcloud.sh \
     && /tmp/gcloud.sh --disable-prompts --install-dir=/opt \
     && /opt/google-cloud-sdk/bin/gcloud components install -q kubectl \
     && ln -s /opt/google-cloud-sdk/bin/* /usr/local/bin


