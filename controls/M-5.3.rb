# attributes
CONTAINER_CAPADD = attribute(
  'container_capadd',
  description: 'define needed capabilities for containers.'
)

control "M-5.3" do
  title "5.3 Ensure Linux Kernel Capabilities are restricted within
containers(Scored)"
  desc  "
    By default, Docker starts containers with a restricted set of Linux Kernel
Capabilities. It
    means that any process may be granted the required capabilities instead of
root access.
    Using Linux Kernel Capabilities, the processes do not have to run as root
for almost all the
    specific areas where root privileges are usually needed.
    Docker supports the addition and removal of capabilities, allowing the use
of a non-default
    profile. This may make Docker more secure through capability removal, or
less secure
    through the addition of capabilities. It is thus recommended to remove all
capabilities
    except those explicitly required for your container process.
    For example, capabilities such as below are usually not needed for
container process:
    NET_ADMIN
    SYS_ADMIN
    SYS_MODULE

  "
  impact 0.5
  tag "ref": "1.
https://docs.docker.com/engine/security/security/#linux-kernel-capabilities\n2.
http://man7.org/linux/man-pages/man7/capabilities.7.html\n3.
http://www.oreilly.com/webops-perf/free/files/docker-security.pdf\n"
  tag "severity": "medium"
  tag "cis_id": "5.3"
  tag "cis_control": ["5.1", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["AC-6(9)", "4"]
  tag "check_text": "docker ps --quiet --all | xargs docker inspect --format '{{ .Id
}}: CapAdd={{\n.HostConfig.CapAdd }} CapDrop={{ .HostConfig.CapDrop }}'\nVerify
that the added and dropped Linux Kernel Capabilities are in line with the
ones\nneeded for container process for each container instance.\n"
  tag "fix": "Execute the below command to add needed capabilities:\n$> docker
run --cap-add={\"Capability 1\",\"Capability 2\"}\nFor example,\ndocker run
--interactive --tty --cap-add={\"NET_ADMIN\",\"SYS_ADMIN\"}\ncentos:latest
/bin/bash\nExecute the below command to drop unneeded capabilities:\n$> docker
run --cap-drop={\"Capability 1\",\"Capability 2\"}\nFor example,\ndocker run
--interactive --tty --cap-drop={\"SETUID\",\"SETGID\"}
centos:latest\n/bin/bash\nAlternatively,\nYou may choose to drop all
capabilities and add only add the needed ones:\n$> docker run --cap-drop=all
--cap-add={\"Capability 1\",\"Capability 2\"}\nFor example,\ndocker run
--interactive --tty --cap-drop=all --capadd={\"NET_ADMIN\",\"SYS_ADMIN\"}
centos:latest /bin/bash\n"
  tag "Default Value": "By default, below capabilities are available for
containers:\nAUDIT_WRITE\nCHOWN\nDAC_OVERRIDE\nFOWNER\nFSETID\nKILL\nMKNOD\nNET_BIND_SERVICE\nNET_RAW\nSETFCAP\nSETGID\nSETPCAP\nSETUID\nSYS_CHROOT\n"
  ref url: 'https://docs.docker.com/engine/security/security/'
  ref url: 'http://man7.org/linux/man-pages/man7/capabilities.7.html'
  ref url: 'https://github.com/docker/docker/blob/master/oci/defaults_linux.go#L64-L79'

  docker.containers.running?.ids.each do |id|
    describe docker.object(id) do
      its(%w(HostConfig CapDrop)) { should include(/all/) }
      its(%w(HostConfig CapDrop)) { should_not eq nil }
      its(%w(HostConfig CapAdd)) { should eq CONTAINER_CAPADD }
    end
  end
end
