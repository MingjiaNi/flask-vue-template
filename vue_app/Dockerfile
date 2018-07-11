FROM node:carbon

COPY ./docker/entrypoint.sh /entrypoint/

RUN ["chmod", "+x", "entrypoint/entrypoint.sh"]

# Copy or mount node app here
WORKDIR /var/www/flask-vue-template/vue_app

EXPOSE 8081

ENTRYPOINT ["/entrypoint/entrypoint.sh"]
