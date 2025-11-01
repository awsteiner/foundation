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
NICKS := ubuntu opensuse arch m1 m2
# Dockerfiles
DFILE := u24.04_tf_2.20_torch_2.9 ost_tf_2.19_torch_2.7.1 arch \
	cuda_12.6_tf_2.18_torch_2.7_m1 cuda_12.8_tf_2.18_torch_2.7_m2

define RULE_tlate
$(1).nc:
	sudo docker buildx build . \
		-f $$(word $(2), $(DFILE)) \
		-t awsteiner/foundation:$$(word $(2), $(DFILE)) \
		--no-cache \
		--target working | tee $(1).out 2>&1 &

$(1).build:
	sudo docker buildx build . \
		-f $$(word $(2), $(DFILE)) \
		-t awsteiner/foundation:$$(word $(2), $(DFILE)) \
		--target working | tee $(1).out 2>&1 &

$(1).check:
	sudo docker run --gpus all --rm \
		-t awsteiner/foundation:$$(word $(2), $(DFILE)) \
		sh -c "cd /opt; ./tf_check.sh; ./torch_check.sh" \
		| tee $(1).cout &

$(1).run:
	sudo docker run --gpus all -it --rm \
		-t awsteiner/foundation:$$(word $(2), $(DFILE))

$(1).push:
	sudo docker push \
		awsteiner/foundation:$$(word $(2), $(DFILE))

endef

# Loop over the indices of the targets
INDEX := $(shell seq 1 $(words $(NICKS)))
$(foreach i,$(INDEX),$(eval $(call RULE_tlate,$(word $(i),$(NICKS)),$(i))))

# ----------------------------------------------------------------------



