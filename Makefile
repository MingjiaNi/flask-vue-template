REMOTE := *
PACKAGE := flask-vue-template
PRODUCTION := prod

build:
ifeq ($(env), prod)
	cp flask_app/config/flask-site-nginx-prod.conf flask_app/config/flask-site-nginx.conf
	docker build -f flask_app/Dockerfile_prod --tag $(PACKAGE)/$(PRODUCTION) .
else
	cp flask_app/config/flask-site-nginx-dev.conf flask_app/config/flask-site-nginx.conf
	docker-compose build
endif

push:
	eval $(shell aws ecr get-login --region us-west-2 --no-include-email)
ifeq ($(env), prod)
	docker tag $(PACKAGE)/$(PRODUCTION) $(REMOTE)/$(PACKAGE)/$(PRODUCTION)
	docker push $(REMOTE)/$(PACKAGE)/$(PRODUCTION)
endif

run:
ifeq ($(env), prod)
	docker run --rm -p 8080:80 $(PACKAGE)/$(PRODUCTION)
else
	docker-compose up
endif
