HUB_PUBLISHER?=coqueirotree

create_images:
	@./dev/make-distribution.sh --name custom-spark --pip --r --tgz -Psparkr -Phive -Phive-thriftserver -Pmesos -Pyarn -Pkubernetes -Dhadoop.version=3.2.0
	@docker build -t ${HUB_PUBLISHER}/spark:3.0.0-hadoop3.2 -f resource-managers/kubernetes/docker/src/main/dockerfiles/spark/Dockerfile .
	@docker build -t ${HUB_PUBLISHER}/spark-py:3.0.0-hadoop3.2 --build-arg base_img=spark:3.0.0-hadoop3.2 -f resource-managers/kubernetes/docker/src/main/dockerfiles/spark/bindings/python/Dockerfile .

push:
	@docker push ${HUB_PUBLISHER}/spark:3.0.0-hadoop3.2
	@docker push ${HUB_PUBLISHER}/spark-py:3.0.0-hadoop3.2

login:
	@docker login --username ${HUB_PUBLISHER} --password ${HUB_PASSWORD}