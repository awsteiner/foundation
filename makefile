help:
	@echo "The makefile targets are of the form [image nickname].[action]."
	@echo ""
	@echo "Nicknames:"
	@echo "---------------------------------------------------------------"
	@echo "ubuntu    Ubuntu 24.04; no GPU support"
	@echo "opensuse  openSUSE Tumbleweed"
	@echo "arch      Arch Linux"
	@echo "m1        Ubuntu 24.04; GPU method 1"
	@echo "m2        Ubuntu 24.04; GPU method 2"
	@echo "u25       Ubuntu 25.04"
	@echo ""
	@echo "Actions:"
	@echo "---------------------------------------------------------------"
	@echo "build     Build the image"
	@echo "nc        Build the image with --no-cache"
	@echo "check     Check the build"
	@echo "run       Run the image with -it --rm"
	@echo "push      Push the image to hub.docker.com"
	@echo "pull      Pull the image from hub.docker.com"
	@echo ""

docker_clean:
	-sudo docker rm \
	`sudo docker ps --all | grep -i -v container | awk '{print $$1}'`
	-sudo docker rmi \
	`sudo docker images --all | grep -i -v container | awk '{print $$3}'`

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

# Nicknames
NICKS := ubuntu opensuse arch m1 m2 u25
# Dockerfiles
DFILE := u24.04_tf_2.20_torch_2.9 ost_tf_2.20_torch_2.9 arch \
	cuda_13.0_tf_2.20_torch_2.10_m1 cuda_12.8_tf_2.20_torch_2.9_m2 \
	u25.04_tf_2.20_torch_2.9

define RULE_tlate
$(1).nc:
	( sudo docker buildx build . --progress=plain \
		-f $$(word $(2), $(DFILE)) \
		-t awsteiner/foundation:$$(word $(2), $(DFILE)) \
		--no-cache \
		--target working | tee $(1).out 2>&1 ) &

$(1).build:
	( sudo docker buildx build . --progress=plain \
		-f $$(word $(2), $(DFILE)) \
		-t awsteiner/foundation:$$(word $(2), $(DFILE)) \
		--target working | tee $(1).out 2>&1 ) &

$(1).check:
	( sudo docker run --gpus all --rm \
		-t awsteiner/foundation:$$(word $(2), $(DFILE)) \
		sh -c "cd /opt; ./tf_check.sh; ./torch_check.sh" \
		| tee $(1).cout ) &

$(1).run:
	sudo docker run --gpus all -it --rm \
		-t awsteiner/foundation:$$(word $(2), $(DFILE))

$(1).push:
	sudo docker push \
		awsteiner/foundation:$$(word $(2), $(DFILE))

$(1).pull:
	sudo docker pull \
		awsteiner/foundation:$$(word $(2), $(DFILE))

endef

# Loop over the indices of the targets
INDEX := $(shell seq 1 $(words $(NICKS)))
$(foreach i,$(INDEX),$(eval $(call RULE_tlate,$(word $(i),$(NICKS)),$(i))))

# ----------------------------------------------------------------------



