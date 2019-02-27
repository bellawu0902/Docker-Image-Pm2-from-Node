# Arg Version
ARG NODEVERSION

# Base image
FROM node:${NODEVERSION}-alpine

# Install
RUN apk update && apk upgrade && \
    apk add --no-cache \
    make \
    gcc \
    g++ \
    git \
    python \
    py-pip \
    vim \
	bash \
	tzdata

# Modify Timezone to Asia/Taipei
RUN ln -sf /usr/share/zoneinfo/Asia/Taipei /etc/localtime \
    && echo "Asia/Taipei" > /etc/timezone

# Install PM2
RUN npm install pm2 -g

# Check Timezone and Version
RUN date
RUN node -v && npm -v && pm2 -v

# Install PM2 Logrotate
RUN pm2 install pm2-logrotate

# Logrotate Setting (Log Format and Crontab Time)
RUN pm2 set pm2-logrotate:dateFormat YYYY-MM-DD
RUN pm2 set pm2-logrotate:compress true
RUN pm2 set pm2-logrotate:rotateInterval '0 0 * * *'