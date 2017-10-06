control "M-5.16" do
  title "5.16 Ensure the host's IPC namespace is not shared (Scored)"
  desc  "
    IPC (POSIX/SysV IPC) namespace provides separation of named shared memory
segments,
    semaphores and message queues. IPC namespace on the host thus should not be
shared
    with the containers and should remain isolated.
    IPC namespace provides separation of IPC between the host and containers.
If the host's
    IPC namespace is shared with the container, it would basically allow
processes within the
    container to see all of the IPC on the host system. This breaks the benefit
of IPC level
    isolation between the host and the containers. Someone having access to the
container can
    eventually manipulate the host IPC. This can be catastrophic. Hence, do not
share the host's
    IPC namespace with the containers.

  "
  impact 0.5
  tag "ref": "1.
https://docs.docker.com/engine/reference/run/#ipc-settings-ipc\n2.
http://man7.org/linux/man-pages/man7/namespaces.7.html\n"
  tag "severity": "medium"
  tag "cis_id": "5.16"
  tag "cis_control": ["18", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["SI-1", "4"]
  tag "check_text": "docker ps --quiet --all | xargs docker inspect --format '{{ .Id
}}:\nIpcMode={{ .HostConfig.IpcMode }}'\nIf the above command returns host, it
means the host IPC namespace is shared with the\ncontainer. If the above
command returns nothing, then the host's IPC namespace is not\nshared. This
recommendation is then compliant.\n"
  tag "fix": "Do not start a container with --ipc=host argument. For example,
do not start a container\nas below:\ndocker run --interactive --tty --ipc=host
centos /bin/bash\n"
  tag "Default Value": "By default, all containers have the IPC namespace
enabled and host IPC namespace is not\nshared with any container.\n"
  ref url: 'https://docs.docker.com/engine/reference/run/#ipc-settings'
  ref url: 'http://man7.org/linux/man-pages/man7/pid_namespaces.7.html'

  docker.containers.running?.ids.each do |id|
    describe docker.object(id) do
      its(%w(HostConfig IpcMode)) { should_not eq 'host' }
    end
  end
end
