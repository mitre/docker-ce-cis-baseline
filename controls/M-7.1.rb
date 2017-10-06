control "M-7.1" do
  title "7.1 Ensure swarm mode is not Enabled, if not needed (Scored)"
  desc  "
    Do not enable swarm mode on a docker engine instance unless needed.
    By default, a Docker engine instance will not listen on any network ports,
with all
    communications with the client coming over the Unix socket. When Docker
swarm mode is
    enabled on a docker engine instance, multiple network ports are opened on
the system and
    made available to other systems on the network for the purposes of cluster
management
    and node communications.
    Opening network ports on a system increase its attack surface and this
should be avoided
    unless required.

  "
  impact 0.5
  tag "severity": "medium"
  tag "cis_id": "7.1"
  tag "cis_control": ["9.1", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["CM-7(1)", "4"]
  tag "check_text": "Review the output of the docker info command. If the output
includes Swarm: active it\nindicates that swarm mode has been activated on the
Docker engine. Confirm if swarm\nmode on the docker engine instance is actually
needed.\n"
  tag "fix": "If swarm mode has been enabled on a system in error, run\ndocker
swarm leave\n"
  tag "Default Value": "By default, docker swarm mode is not enabled.\n"
  ref 'docker swarm init', url: 'https://docs.docker.com/engine/reference/commandline/swarm_init/'

  describe docker.info do
    its('Swarm.LocalNodeState') { should eq SWARM_MODE }
  end
end
