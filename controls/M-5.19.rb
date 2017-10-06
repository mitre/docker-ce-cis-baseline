control "M-5.19" do
  title "5.19 Ensure mount propagation mode is not set to shared (Scored)"
  desc  "
    Mount propagation mode allows mounting volumes in shared, slave or private
mode on a
    container. Do not use shared mount propagation mode until needed.
    A shared mount is replicated at all mounts and the changes made at any
mount point are
    propagated to all mounts. Mounting a volume in shared mode does not
restrict any other
    container to mount and make changes to that volume. This might be
catastrophic if the
    mounted volume is sensitive to changes. Do not set mount propagation mode
to shared
    until needed.

  "
  impact 0.5
  tag "ref": "1. https://github.com/docker/docker/pull/17034\n2.
https://docs.docker.com/engine/reference/run/#volume-shared-filesystems\n3.
https://www.kernel.org/doc/Documentation/filesystems/sharedsubtree.txt\n"
  tag "severity": "medium"
  tag "cis_id": "5.19"
  tag "cis_control": ["14", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["AC-6", "4"]
  tag "check_text": "docker ps --quiet --all | xargs docker inspect --format '{{ .Id
}}:\nPropagation={{range $mnt := .Mounts}} {{json $mnt.Propagation}}
{{end}}'\nThe above command would return the propagation mode for mounted
volumes.\nPropagation mode should not be set to shared unless needed. The above
command might\nthrow errors if there are no mounts. In that case, this
recommendation is not applicable.\n"
  tag "fix": "Do not mount volumes in shared mode propagation.\nFor example, do
not start container as below:\ndocker run <Run arguments>
--volume=/hostPath:/containerPath:shared\n<Container Image Name or ID>
<Command>\n"
  tag "Default Value": "By default, the container mounts are private.\n"
  ref url: 'https://github.com/docker/docker/pull/17034'
  ref url: 'https://docs.docker.com/engine/reference/run/'
  ref url: 'https://www.kernel.org/doc/Documentation/filesystems/sharedsubtree.txt'

  docker.containers.running?.ids.each do |id|
    raw = command("docker inspect --format '{{range $mnt := .Mounts}} {{json $mnt.Propagation}} {{end}}' #{id}").stdout
    describe raw.delete("\n").delete('\"').delete(' ') do
      it { should_not eq 'shared' }
    end
  end
end
