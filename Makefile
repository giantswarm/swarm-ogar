# standard info
PROJECT = ogar
REGISTRY = registry.giantswarm.io
USERNAME := $(shell swarm user)
ORG := $(shell swarm env | cut -d"/" -f1)
ENV := $(shell swarm env | cut -d"/" -f2)

# domain settings
HOSTNAME=ogar-$(USERNAME).gigantic.io
CNAME=$(HOSTNAME)
DEV_HOSTNAME=$(shell boot2docker ip):443
DEV_CNAME=$(DEV_HOSTNAME)

docker-build:
	docker build -t $(REGISTRY)/$(USERNAME)/$(PROJECT) .

docker-run: docker-build
	@echo "Use ws://$(DEV_CNAME) from agar.io to play game."
	docker run --name=ogar --rm -ti \
		-e "HOSTNAME=$(DEV_HOSTNAME)" \
		-e "CNAME=$(DEV_CNAME)" \
		-e "ORG=$(ORG)" \
		-e "ENV=$(ENV)" \
		-p 443:443 \
		$(REGISTRY)/$(USERNAME)/$(PROJECT)

docker-push: docker-build
	docker push $(REGISTRY)/$(USERNAME)/$(PROJECT)

docker-pull:
	docker pull $(REGISTRY)/$(USERNAME)/$(PROJECT)

swarm-up: docker-push
	swarm up \
	  --var=username=$(USERNAME) \
	  --var=org=$(ORG) \
	  --var=env=$(ENV) \
	  --var=domain=$(CNAME) \
	  --var=app=$(PROJECT)
	@echo "Use ws://$(CNAME) from agar.io to play game."
