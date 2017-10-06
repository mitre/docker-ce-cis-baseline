control "M-5.11" do
  title "5.11 Ensure CPU priority is set appropriately on the container
(Scored)"
  desc  "
    By default, all containers on a Docker host share the resources equally. By
using the
    resource management capabilities of Docker host, such as CPU shares, you
can control the
    host CPU resources that a container may consume.
    By default, CPU time is divided between containers equally. If it is
desired, to control the
    CPU time amongst the container instances, you can use CPU sharing feature.
CPU sharing
    allows to prioritize one container over the other and forbids the lower
priority container to
    claim CPU resources more often. This ensures that the high priority
containers are served
    better.

  "
  impact 0.5
  tag "ref": "1.
https://goldmann.pl/blog/2014/09/11/resource-management-in-docker/\n2.
https://docs.docker.com/engine/reference/commandline/run/#options\n3.
https://docs.docker.com/engine/admin/runmetrics/\n"
  tag "severity": "medium"
  tag "cis_id": "5.11"
  tag "cis_control": ["18", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["SI-1", "4"]
  tag "check_text": "docker ps --quiet --all | xargs docker inspect --format '{{ .Id
}}:\nCpuShares={{ .HostConfig.CpuShares }}'\nIf the above command returns 0 or
1024, it means the CPU shares are not in place. If the\nabove command returns a
non-zero value other than 1024, it means CPU shares are in\nplace.\n"
  tag "fix": "Manage the CPU shares between your containers. To do so start the
container using the -cpu-shares argument.\nFor example, you could run a
container as below:\ndocker run --interactive --tty --cpu-shares 512 centos
/bin/bash\nIn the above example, the container is started with CPU shares of
50% of what the other\ncontainers use. So, if the other container has CPU
shares of 80%, this container will have\nCPU shares of 40%.\nNote: Every new
container will have 1024 shares of CPU by default. However, this value
is\nshown as 0 if you run the command mentioned in the audit
section.\nAlternatively,\n1. Navigate to /sys/fs/cgroup/cpu/system.slice/
directory.\n2. Check your container instance ID using docker ps.\n3. Now,
inside the above directory (in step 1), you would have a directory by
name\ndocker-<Instance ID>.scope. For example,
docker4acae729e8659c6be696ee35b2237cc1fe4edd2672e9186434c5116e1a6fbed6.scope.\nNavigate
to this directory.\n4. You will find a file named cpu.shares. Execute cat
cpu.shares. This will always\ngive you the CPU share value based on the system.
So, even if there is no CPU shares\nconfigured using -c or --cpu-shares
argument in the docker run command, this\nfile will have a value of 1024.\nIf
we set one container’s CPU shares to 512 it will receive half of the CPU time
compared to\nthe other container. So, take 1024 as 100% and then do quick math
to derive the number\nthat you should set for respective CPU shares. For
example, use 512 if you want to set 50%\nand 256 if you want to set 25%.\n"
  tag "Default Value": "By default, all containers on a Docker host share the
resources equally. No CPU shares are\nenforced.\n"
  ref url: 'https://goldmann.pl/blog/2014/09/11/resource-management-in-docker/'
  ref url: 'https://docs.docker.com/engine/reference/commandline/cli/#run'
  ref url: 'https://docs.docker.com/v1.8/articles/runmetrics/'

  docker.containers.running?.ids.each do |id|
    describe docker.object(id) do
      its(%w(HostConfig CpuShares)) { should_not eq 0 }
      its(%w(HostConfig CpuShares)) { should_not eq 1024 }
    end
  end
end
