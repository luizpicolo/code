FROM ruby:latest

# Install all the things
RUN apt-get update && apt-get install -y build-essential curl git postgresql-9.4 libpq-dev nginx && \
  unlink /etc/nginx/sites-enabled/default && \
  curl -o /tmp/s6-overlay-amd64.tar.gz -L $(curl -s https://api.github.com/repos/just-containers/s6-overlay/releases/latest | grep browser_download_url | head -1 | cut -d '"' -f 4) && \
  tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

# Application
ADD . /app
WORKDIR /app

RUN cd /app && \
  bundle install

ENV PGDATA=/var/lib/postgresql \
  PGHOST=localhost \
  PGDBNAME=code_production \
  PGUSERNAME=code \
  PGPASSWORD=code \
  RAILS_ENV=production \
  RAILS_SECRET=fd0f51a314e0852b595185f2c415ef035527c3e21b6fb7a7b15c1a1833d5a649081e0abb6437750c8a24dc6ec0c3e93edee9f5e3255a9d604e1f6df0050991bf

# Services and Initializer
ADD config/docker/ /

# Volumes
VOLUME /var/lib/postgresql

# Entrypoint
ENTRYPOINT ["/init"]

# Expose
EXPOSE 80
