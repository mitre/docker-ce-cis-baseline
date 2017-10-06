control "M-5.21" do
  title "5.21 Ensure the default seccomp profile is not Disabled (Scored)"
  desc  "
    Seccomp filtering provides a means for a process to specify a filter for
incoming system
    calls. The default Docker seccomp profile works on whitelist basis and
allows 311 system
    calls blocking all others. It should not be disabled unless it hinders your
container
    application usage.
    A large number of system calls are exposed to every userland process with
many of them
    going unused for the entire lifetime of the process. Most of the
applications do not need all
    the system calls and thus benefit by having a reduced set of available
system calls. The
    reduced set of system calls reduces the total kernel surface exposed to the
application and
    thus improvises application security.

  "
  impact 0.5
  tag "ref": "1.
http://blog.scalock.com/new-docker-security-features-and-what-they-meanseccomp-profiles\n2.
https://docs.docker.com/engine/reference/run/#security-configuration\n3.
https://github.com/docker/docker/blob/master/profiles/seccomp/default.json\n4.
https://docs.docker.com/engine/security/seccomp/\n5.
https://www.kernel.org/doc/Documentation/prctl/seccomp_filter.txt\n6.
https://github.com/docker/docker/issues/22870\n"
  tag "severity": "medium"
  tag "cis_id": "5.21"
  tag "cis_control": ["18", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["SI-1", "4"]
  tag "check_text": "docker ps --quiet --all | xargs docker inspect --format '{{ .Id
}}:\nSecurityOpt={{ .HostConfig.SecurityOpt }}'\nThe above command should
return <no value> or your modified seccomp profile. If it\nreturns
[seccomp:unconfined], that means this recommendation is non-compliant and
the\ncontainer is running without any seccomp profiles.\n"
  tag "fix": "By default, seccomp profiles are enabled. You do not need to do
anything unless you want\nto modify and use the modified seccomp profile.\n"
  tag "Default Value": "When you run a container, it uses the default profile
unless you override it with the -security-opt option.\n"
  ref url: 'https://docs.docker.com/engine/reference/run/'
  ref url: 'http://blog.aquasec.com/new-docker-security-features-and-what-they-mean-seccomp-profiles'
  ref url: 'https://github.com/docker/docker/blob/master/profiles/seccomp/default.json'
  ref url: 'https://docs.docker.com/engine/security/seccomp/'
  ref url: 'https://www.kernel.org/doc/Documentation/prctl/seccomp_filter.txt'
  ref url: 'https://github.com/docker/docker/pull/17034'

  docker.containers.running?.ids.each do |id|
    describe docker.object(id) do
      its(%w(HostConfig SecurityOpt)) { should include(/seccomp/) }
      its(%w(HostConfig SecurityOpt)) { should_not include(/seccomp[=|:]unconfined/) }
    end
  end
end
