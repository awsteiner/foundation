help:
	@echo "Docker targets (not part of autoconf package):"
	@echo "---------------------------------------------------"
	@echo "docker_clean:"
	@echo "docker_clean2:"
	@echo "docker_show:"
	@echo "docker_stop:"

docker_clean:
	-sudo docker rm \
	`sudo docker ps --all | grep -i -v container | awk '{print $$1}'`
	-sudo docker rmi \
	`sudo docker images --all | grep -i -v container | awk '{print $$3}'`

docker_show:
	- sudo docker ps --all
	- sudo docker images --all
	- sudo docker system df

docker_make_cache:
	sudo docker create -v /mnt/ccache:/ccache --name ccache debian

docker_mount_cache:
	sudo docker run -e CCACHE_DIR=/ccache --volumes-from ccache -it debian

DOCKER_PS_Q = $(shell sudo docker ps -q)

docker_stop:
	- sudo docker stop $(DOCKER_PS_Q)

docker_clean2:
	- sudo docker image prune -a
	- sudo docker stop $(sudo docker ps -q)
	- sudo docker container prune
	- sudo docker buildx prune -f
	- sudo docker system df

# ----------------------------------------------------------------------

tt0.build:
	sudo docker buildx build . \
		-f tf_2.18_torch_2.7 \
		-t awsteiner/foundation:tf_2.18_torch_2.7 \
		--target working > tt0.out 2>&1 &

tt0.run:
	sudo docker run --gpus all \
		-t awsteiner/foundation:tf_2.18_torch_2.7 \
		sh -c "cd /opt; ./tf_check.sh; ./torch_check.sh"

# ----------------------------------------------------------------------

tt.build:
	sudo docker buildx build . \
		-f cuda_12.6_tf_2.18_torch_2.7_m1 \
		-t awsteiner/foundation:cuda_12.6_tf_2.18_torch_2.7_m1 \
		--target working > tt.out 2>&1 &

tt.run:
	sudo docker run --gpus all \
		-t awsteiner/foundation:cuda_12.6_tf_2.18_torch_2.7_m1 \
		sh -c "cd /opt; ./tf_check.sh; ./torch_check.sh"

# ----------------------------------------------------------------------

tt2.build:
	sudo docker buildx build --no-cache . \
		-f cuda_12.8_tf_2.18_torch_2.7_m2 \
		-t awsteiner/foundation:cuda_12.8_tf_2.18_torch_2.7_m2 \
		--target working

#> tt2.out 2>&1 &

tt2.run:
	sudo docker run --gpus all \
		-t awsteiner/foundation:cuda_12.8_tf_2.18_torch_2.7_m2 \
		sh -c "cd /opt; ./tf_check.sh; ./torch_check.sh"

tt2.it:
	sudo docker run -it --gpus all \
		-t awsteiner/foundation:cuda_12.8_tf_2.18_torch_2.7_m2 

