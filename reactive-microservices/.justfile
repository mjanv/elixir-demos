# sudo cgcreate -t mjanvier:mjanvier -a mjanvier:mjanvier -g memory:/pipelines
# echo $(( 1024 * 1024 * 1024 )) | sudo tee /sys/fs/cgroup/memory/pipelines/memory.limit_in_bytes
# echo $(( 0 )) | sudo tee /sys/fs/cgroup/memory/pipelines/memory.memsw.limit_in_bytes
# cgexec -g memory:pipelines _build/dev/rel/pipelines/bin/pipelines start
# cgexec -g memory:pipelines _build/dev/rel/pipelines/bin/pipelines remote
