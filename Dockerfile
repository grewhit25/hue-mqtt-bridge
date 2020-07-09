FROM alpine
LABEL MAINTAINER="Greg White <grewhit25@gmail.com>"
# https://github.com/dale3h/hue-mqtt-bridge
# install nodejs
RUN apk add --update bash npm nodejs
# Create our application direcory
WORKDIR /usr/src/app
# Copy and install dependencies
# COPY package.json /usr/src/app/
COPY . /usr/src/app
RUN npm install --silent --production \
    && npm audit fix \
    && rm -rf /var/cache/apk/*
# Copy everything else
COPY config.sample.json /config/config.json
# Expose Configuration Volume
VOLUME /config
ENTRYPOINT [ "tini", "--" ]
CMD [ "npm", "start" ]
