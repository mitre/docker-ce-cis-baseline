control "M-2.16" do
  title "2.16 Ensure daemon-wide custom seccomp profile is applied, if
needed(Not Scored)"
  desc  "
    You can choose to apply your custom seccomp profile at the daemon-wide
level if needed
    and override Docker's default seccomp profile.
    A large number of system calls are exposed to every userland process with
many of them
    going unused for the entire lifetime of the process. Most of the
applications do not need all
    the system calls and thus benefit by having a reduced set of available
system calls. The
    reduced set of system calls reduces the total kernel surface exposed to the
application and
    thus improvises application security.
    You could apply your own custom seccomp profile instead of Docker's default
seccomp
    profile. Alternatively, if Docker's default profile is good for your
environment, you can
    choose to ignore this recommendation.

  "
  impact 0.5
  tag "ref": "1. https://docs.docker.com/engine/security/seccomp/\n2.
https://github.com/docker/docker/pull/26276\n"
  tag "severity": "medium"
  tag "cis_id": "2.16"
  tag "cis_control": ["18", "6.1"]
  tag "cis_level": "Level 2 - Docker"
  tag "nist": ["SI-1", "4"]
  tag "check_text": "Run the below command and review the seccomp profile listed in
the Security Options\nsection. If it is default, that means, Docker's default
seccomp profile is applied.\ndocker info --format '{{ .SecurityOptions }}'\n"
  tag "fix": "By default, Docker's default seccomp profile is applied. If this
is good for your environment,\nno action is necessary. Alternatively, if you
choose to apply your own seccomp profile, use\nthe --seccomp-profile flag at
daemon start or put it in the daemon runtime parameters\nfile.\ndockerd
--seccomp-profile </path/to/seccomp/profile>\n"
  tag "Default Value": "By default, Docker applies a seccomp profile.\n"
end
