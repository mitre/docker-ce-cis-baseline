control "M-5.15" do
  title "5.15 Ensure the host's process namespace is not shared (Scored)"
  desc  "
    Process ID (PID) namespaces isolate the process ID number space, meaning
that processes
    in different PID namespaces can have the same PID. This is process level
isolation between
    containers and the host.
    PID namespace provides separation of processes. The PID Namespace removes
the view of
    the system processes, and allows process ids to be reused including PID 1.
If the host's PID
    namespace is shared with the container, it would basically allow processes
within the
    container to see all of the processes on the host system. This breaks the
benefit of process
    level isolation between the host and the containers. Someone having access
to the
    container can eventually know all the processes running on the host system
and can even
    kill the host system processes from within the container. This can be
catastrophic. Hence,
    do not share the host's process namespace with the containers.

  "
  impact 0.5
  tag "ref": "1.
https://docs.docker.com/engine/reference/run/#pid-settings-pid\n2.
http://man7.org/linux/man-pages/man7/pid_namespaces.7.html\n"
  tag "severity": "medium"
  tag "cis_id": "5.15"
  tag "cis_control": ["18", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["SI-1", "4"]
  tag "check_text": "docker ps --quiet --all | xargs docker inspect --format '{{ .Id
}}:\nPidMode={{ .HostConfig.PidMode }}'\nIf the above command returns host, it
means the host PID namespace is shared with the\ncontainer else this
recommendation is compliant.\n"
  tag "fix": "Do not start a container with --pid=host argument.\nFor example,
do not start a container as below:\ndocker run --interactive --tty --pid=host
centos /bin/bash\n"
  tag "Default Value": "By default, all containers have the PID namespace
enabled and the host's process\nnamespace is not shared with the containers.\n"
  ref url: 'https://docs.docker.com/engine/reference/run/#pid-settings'
  ref url: 'http://man7.org/linux/man-pages/man7/pid_namespaces.7.html'

  docker.containers.running?.ids.each do |id|
    describe docker.object(id) do
      its(%w(HostConfig PidMode)) { should_not eq 'host' }
    end
  end
end
