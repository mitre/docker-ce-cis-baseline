SELINUX_PROFILE = attribute(
  'selinux_profile',
  description: 'define SELinux profile for Docker containers. cis-docker-benchmark-5.2',
  default:  /label\:level\:s0-s0\:c1023/
)

control "M-5.2" do
  title "5.2 Ensure SELinux security options are set, if applicable (Scored)"
  desc  "
    SELinux is an effective and easy-to-use Linux application security system.
It is available on
    quite a few Linux distributions by default such as Red Hat and Fedora.
    SELinux provides a Mandatory Access Control (MAC) system that greatly
augments the
    default Discretionary Access Control (DAC) model. You can thus add an extra
layer of safety
    by enabling SELinux on your Linux host, if applicable.

  "
  impact 0.5
  tag "ref":
"1.\n2.\n3.\n4.\nhttps://docs.docker.com/engine/security/security/#other-kernel-security-features\nhttps://docs.docker.com/engine/reference/run/#security-configuration\nhttp://docs.fedoraproject.org/en-US/Fedora/13/html/Security-Enhanced_Linux/\nhttps://access.redhat.com/documentation/enus/red_hat_enterprise_linux_atomic_host/7/html/container_security_guide/docker_\nselinux_security_policy\n"
  tag "severity": "medium"
  tag "cis_id": "5.2"
  tag "cis_control": ["14.4", "6.1"]
  tag "cis_level": "Level 2 - Docker"
  tag "nist": ["AC-3 (3)", "4"]
  tag "check_text": "docker ps --quiet --all | xargs docker inspect --format '{{ .Id
}}:\nSecurityOpt={{ .HostConfig.SecurityOpt }}'\nThe above command should
return all the security options currently configured for the\ncontainers.\n"
  tag "fix": "If SELinux is applicable for your Linux OS, use it. You may have
to follow below set of steps:\n1.\n2.\n3.\n4.\nSet the SELinux State.\nSet the
SELinux Policy.\nCreate or import a SELinux policy template for Docker
containers.\nStart Docker in daemon mode with SELinux enabled. For
example,\ndocker daemon --selinux-enabled\n5. Start your Docker container using
the security options. For example,\ndocker run --interactive --tty
--security-opt label=level:TopSecret centos\n/bin/bash\n"
  tag "Default Value": "By default, no SELinux security options are applied on
containers.\n"
  ref 'Bug: Wrong SELinux label for devmapper device', url: 'https://github.com/docker/docker/issues/22826'
  ref 'Bug: selinux break docker user namespace', url: 'https://bugzilla.redhat.com/show_bug.cgi?id=1312665'
  ref url: 'https://docs.docker.com/engine/security/security/'
  ref url: 'https://docs.docker.com/engine/reference/run/#security-configuration'
  ref url: 'https://docs.fedoraproject.org/en-US/Fedora/13/html/Security-Enhanced_Linux/'

  only_if { %w(centos redhat).include? os[:name] }
  describe json('/etc/docker/daemon.json') do
    its(['selinux-enabled']) { should eq(true) }
  end

  docker.containers.running?.ids.each do |id|
    describe docker.object(id) do
      its(%w(HostConfig SecurityOpt)) { should_not eq nil }
      its(%w(HostConfig SecurityOpt)) { should include(SELINUX_PROFILE) }
    end
  end
end
