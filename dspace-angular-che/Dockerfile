FROM eclipse/ubuntu_jre
ENV ADDRESS 0.0.0.0
ENV NODE_PATH /usr/local/lib/node_modules
ENV NODE_VERSION 6.10.3
ENV DSPACE_GIT https://github.com/DSpace/dspace-angular.git

# Instsall Node 6.10
RUN sudo apt-get update && \
    sudo apt-get -y install build-essential libssl-dev libkrb5-dev gcc make ruby-full rubygems-integration python && \
    sudo gem install sass compass && \
    sudo apt-get clean && \
    sudo apt-get -y autoremove && \
    sudo apt-get -y clean && \
    sudo rm -rf /var/lib/apt/lists/* && \
    set -ex \
    && for key in \
      9554F04D7259F04124DE6B476D5A82AC7E37093B \
      94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
      FD3A5288F042B6850C66B31F09FE44734EB7990E \
      71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
      DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
      B9AE9905FFD7803F25714661B63B535A4C206CA9 \
      C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
      56730D5401028683275BD23C23EFEFE93C4CFFFE \
    ; do \
      gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
    done && \
  	cd /home/user && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" \
  	&& curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  	&& gpg --verify SHASUMS256.txt.asc \
  	&& grep "node-v$NODE_VERSION-linux-x64.tar.gz\$" SHASUMS256.txt.asc | sha256sum -c - \
  	&& sudo tar -xzf "node-v$NODE_VERSION-linux-x64.tar.gz" -C /usr/local --strip-components=1 \
  	&& sudo rm "node-v$NODE_VERSION-linux-x64.tar.gz" SHASUMS256.txt.asc

EXPOSE 3000 5000 9000

# Install Yarn
RUN sudo npm install --unsafe-perm -g grunt grunt-cli yarn

# Correct permissions
RUN sudo chown -R user:user $NODE_PATH \
      && sudo chown -R user:user /projects

# Preload node_modules
RUN set -x \
      && git clone ${DSPACE_GIT} /projects/dspace-angular \
      && cd /projects/dspace-angular \
      && yarn run global \
      && yarn install \
      && rm -rf /projects/dspace-angular

WORKDIR /projects

CMD tail -f /dev/null
