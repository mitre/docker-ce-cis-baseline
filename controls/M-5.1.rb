control "M-5.1" do
  title "5.1 Ensure AppArmor Profile is Enabled (Scored)"
  desc  "
    AppArmor is an effective and easy-to-use Linux application security system.
It is available
    on quite a few Linux distributions by default such as Debian and Ubuntu.
    AppArmor protects the Linux OS and applications from various threats by
enforcing
    security policy which is also known as AppArmor profile. You can create
your own
    AppArmor profile for containers or use the Docker's default AppArmor
profile. This would
    enforce security policies on the containers as defined in the profile.

  "
  impact 0.5
  tag "ref": "1. https://docs.docker.com/engine/security/apparmor/\n2.
https://docs.docker.com/engine/reference/run/#security-configuration\n3.
https://docs.docker.com/engine/security/security/#other-kernel-security-features\n"
  tag "severity": "medium"
  tag "cis_id": "5.1"
  tag "cis_control": ["14.4", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["AC-3 (3)", "4"]
  tag "check_text": "docker ps --quiet --all | xargs docker inspect --format '{{ .Id
}}:\nAppArmorProfile={{ .AppArmorProfile }}'\nThe above command should return a
valid AppArmor Profile for each container instance.\n"
  tag "fix": "If AppArmor is applicable for your Linux OS, use it. You may have
to follow below set of\nsteps:\n1.\n2.\n3.\n4.\nVerify if AppArmor is
installed. If not, install it.\nCreate or import a AppArmor profile for Docker
containers.\nPut this profile in enforcing mode.\nStart your Docker container
using the customized AppArmor profile. For example,\ndocker run --interactive
--tty --security-opt=\"apparmor:PROFILENAME\" centos\n/bin/bash\nAlternatively,
you can keep the docker's default apparmor profile.\n"
  tag "Default Value": "By default, docker-default AppArmor profile is applied
for running containers and this\nprofile can be found at
/etc/apparmor.d/docker.\n"
  ref 'https://docs.docker.com/engine/security/security/'
  ref 'https://docs.docker.com/engine/reference/run/#security-configuration'
  ref 'http://wiki.apparmor.net/index.php/Main_Page'

  only_if { %w(ubuntu debian).include? os[:name] }
  docker.containers.running?.ids.each do |id|
    describe docker.object(id) do
      its(['AppArmorProfile']) { should include(APP_ARMOR_PROFILE) }
      its(['AppArmorProfile']) { should_not eq nil }
    end
  end
end
