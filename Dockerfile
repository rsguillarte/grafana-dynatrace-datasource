FROM grafana/grafana:latest

# Add dynatrace plugin source
ADD grafana-dynatrace-datasource /var/lib/grafana/plugins/grafana-dynatrace-datasource

USER root

# Install prerequisites
RUN apt-get update \
    && apt-get install -y gnupg \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y nodejs \
    && npm install yarn -g

# Change into the dynatrace plugin directory
WORKDIR /var/lib/grafana/plugins/grafana-dynatrace-datasource

# Install dependencies and build the dynatrace plugin
RUN yarn install \
    && npm run build \
    && chown -R grafana:grafana /var/lib/grafana/plugins

USER grafana

WORKDIR /
