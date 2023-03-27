IMAGE_NAME:=amadeusprovideradapter-dwsvc
IMAGE_TAG:=latest
MAVEN_OPTIONS:=-Dmaven.artifact.threads=8 -T 1C

default:
	@cat ./Makefile
clean:
	@./mvnw clean
dist:
	@./mvnw $(MAVEN_OPTIONS) clean install
dist-quick:
	@./mvnw $(MAVEN_OPTIONS) \
	-Dscalatest.skip=true \
	-Dmaven.test.skip=true \
	-Dpmd.skip=true \
	-Dcheckstyle.skip=true \
	-Dfindbugs.skip=true \
	-Djacoco.skip=true \
	-Dtest.skip=true \
	-Dsonar.skip=true \
	-DskipTests=true \
	install
image:
	docker build --build-arg ARTYUSER=$(ARTYUSER) --build-arg ARTYPASS=$(ARTYPASS) -t $(IMAGE_NAME):latest .
run-mvn:
	@echo "Starting service"
	@./mvnw $(MAVEN_OPTIONS) \
	spring-boot:run
run-docker:
	@echo "Starting service"
	@docker run\
	  -e "APP_NAME=$(IMAGE_NAME)" -p 8080:8080 -p 8443:8443 \
	  -e "AWS_REGION=us-west-2" \
      -e "EXPEDIA_SEGMENT=air" \
	  -e "EXPEDIA_ENVIRONMENT=int" \
      -e "SECURITY_CONTEXT=test" \
  	  -e "VAULT_TOKEN=$(shell cat $(HOME)/.vault-token)" \
	  -e "VAULT_ADDR=https://ewe-vault.test.nimbus.expedia.com" \
	  -e "AWS_ACCESS_KEY_ID=$(shell aws configure get aws_access_key_id)"\
      -e "AWS_SECRET_ACCESS_KEY=$(shell aws configure get aws_secret_access_key)"\
      -e "AWS_SESSION_TOKEN=$(shell aws configure get aws_session_token)" \
      $(IMAGE_NAME):$(IMAGE_TAG)
# run-bash:
# 	docker run -i -t $(IMAGE_NAME):$(IMAGE_TAG) /bin/bash
# login:
# 	docker exec -it `docker ps | grep $(IMAGE_NAME):$(IMAGE_TAG) | awk '{print $$1}'` /bin/bash
# run-zinc:
# 	hash zinc && zinc -start
# run-smoketest:
# 	java -DtargetEnvironment=dev -jar acceptance-tests/target/acceptance-tests.jar --plugin pretty --glue com/expedia/supply/air/provideradapter/amadeus/test/step classpath:features --tags ~@Wip --tags ~@Quarantine --tags @BVT
# stack:
# 	@cd sre/docker-compose && ./run-docker-compose.sh
# vault-token:
# 	@cd sre/docker-compose && ./generate-vault-token.sh
# aws-credentials:
# 	@cd sre/docker-compose && ./generate-aws-credentials.sh
# up:  dist-quick image stack
