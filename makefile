help:
	@echo "Docker targets (not part of autoconf package):"
	@echo "---------------------------------------------------"
	@echo "docker_clean:"
	@echo "docker_clean2:"
	@echo "docker_show:"
	@echo "docker_stop:"
	@echo "tt[0,1,2].build:"
	@echo "tt[1,2].check:"
	@echo "tt[0,1,2].run:"
	@echo "tt[0,1,2].push:"

docker_clean:
	-sudo docker rm \
	`sudo docker ps --all | grep -i -v container | awk '{print $$1}'`
	-sudo docker rmi \
	`sudo docker images --all | grep -i -v container | awk '{print $$3}'`

docker_show:
	@echo "Containers:"
	- @sudo docker ps --all
	@echo " "
	@echo "Images:"
	- sudo docker images --all
	@echo " "
	@echo "System:"
	- sudo docker system df
	@echo " "

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

ubuntu.build:
	sudo docker buildx build . \
		-f u24.04_tf_2.18_torch_2.7 \
		--no-cache \
		-t awsteiner/foundation:u24.04_tf_2.18_torch_2.7 \
		--target working > ubuntu.out 2>&1 &

ubuntu.check:
	sudo docker run --gpus all --rm \
		-t awsteiner/foundation:u24.04_tf_2.18_torch_2.7 \
		sh -c "cd /opt; ./tf_check.sh; ./torch_check.sh" \
		> ubuntu.check &

ubuntu.run:
	sudo docker run --gpus all -it --rm \
		-t awsteiner/foundation:u24.04_tf_2.18_torch_2.7 

ubuntu.push:
	sudo docker push \
		awsteiner/foundation:u24.04_tf_2.18_torch_2.7


# ----------------------------------------------------------------------

tt1.build:
	sudo docker buildx build . \
		-f cuda_12.6_tf_2.18_torch_2.7_m1 \
		--no-cache \
		-t awsteiner/foundation:cuda_12.6_tf_2.18_torch_2.7_m1 \
		--target working > tt1.out 2>&1 &

tt1.check:
	sudo docker run --gpus all --rm \
		-t awsteiner/foundation:cuda_12.6_tf_2.18_torch_2.7_m1 \
		sh -c "cd /opt; ./tf_check.sh; ./torch_check.sh" \
		> tt1.check &

tt1.run:
	sudo docker run --gpus all -it --rm \
		-t awsteiner/foundation:cuda_12.6_tf_2.18_torch_2.7_m1 

tt1.push:
	sudo docker push \
		awsteiner/foundation:cuda_12.6_tf_2.18_torch_2.7_m1

# ----------------------------------------------------------------------

tt2.build:
	sudo docker buildx build --no-cache . \
		-f cuda_12.8_tf_2.18_torch_2.7_m2 \
		--no-cache \
		-t awsteiner/foundation:cuda_12.8_tf_2.18_torch_2.7_m2 \
		--target working > tt2.out 2>&1 &

tt2.check:
	sudo docker run --gpus all --rm \
		-t awsteiner/foundation:cuda_12.8_tf_2.18_torch_2.7_m2 \
		sh -c "cd /opt; ./tf_check.sh; ./torch_check.sh" \
		> tt2.check &

tt2.run:
	sudo docker run --gpus all -it --rm \
		-t awsteiner/foundation:cuda_12.8_tf_2.18_torch_2.7_m2 

tt2.push:
	sudo docker push \
		awsteiner/foundation:cuda_12.8_tf_2.18_torch_2.7_m2

# ----------------------------------------------------------------------

arch.build:
	sudo docker buildx build . \
		-f arch -t awsteiner/foundation:arch \
		--no-cache \
		--target working > arch.out 2>&1 &

arch.check:
	sudo docker run --gpus all --rm \
		-t awsteiner/foundation:arch \
		sh -c "cd /opt; ./tf_check.sh; ./torch_check.sh" \
		> arch.check &
arch.run:
	sudo docker run --gpus all -it --rm \
		-t awsteiner/foundation:arch

arch.push:
	sudo docker push \
		awsteiner/foundation:arch


# ----------------------------------------------------------------------

opensuse.build:
	sudo docker buildx build . \
		-f ost_tf_2.18_torch_2.7.1 \
		-t awsteiner/foundation:ost_tf_2.18_torch_2.7.1 \
		--no-cache \
		--target working > opensuse.out 2>&1 &

opensuse.check:
	sudo docker run --gpus all --rm \
		-t awsteiner/foundation:ost_tf_2.18_torch_2.7.1 \
		sh -c "cd /opt; ./tf_check.sh; ./torch_check.sh" \
		> opensuse.check &

opensuse.run:
	sudo docker run --gpus all -it --rm \
		-t awsteiner/foundation:ost_tf_2.18_torch_2.7.1

opensuse.push:
	sudo docker push \
		awsteiner/foundation:ost_tf_2.18_torch_2.7.1


