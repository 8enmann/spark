HUB_PUBLISHER?=coqueirotree

create_images:
	# Optionally add: --r -Psparkr
	@./dev/make-distribution.sh --name custom-spark --pip --tgz -Phive -Phive-thriftserver -Pmesos -Pyarn -Pkubernetes -Dhadoop.version=3.2.0
	@docker build -t ${HUB_PUBLISHER}/spark:3.1.1-hadoop3.2 -f resource-managers/kubernetes/docker/src/main/dockerfiles/spark/Dockerfile .
	@docker build -t ${HUB_PUBLISHER}/spark-py:3.1.1-hadoop3.2 --build-arg base_img=${HUB_PUBLISHER}/spark:3.1.1-hadoop3.2 -f resource-managers/kubernetes/docker/src/main/dockerfiles/spark/bindings/python/Dockerfile .

push:
	@docker push ${HUB_PUBLISHER}/spark:3.1.1-hadoop3.2
	@docker push ${HUB_PUBLISHER}/spark-py:3.1.1-hadoop3.2

login:
	@docker login --username ${HUB_PUBLISHER} --password ${HUB_PASSWORD}