control "M-7.4" do
  title "7.4 Ensure data exchanged between containers are encrypted
on\ndifferent nodes on the overlay network (Scored)"
  desc  "
    Encrypt data exchanged between containers on different nodes on the overlay
network.
    By default, data exchanged between containers on different nodes on the
overlay network
    is not encrypted. This could potentially expose traffic between the
container nodes.

  "
  impact 0.5
  tag "ref": "1.
https://docs.docker.com/engine/userguide/networking/overlay-security-model/\n2.
https://github.com/docker/docker/issues/24253\n"
  tag "severity": "medium"
  tag "cis_id": "7.4"
  tag "cis_control": ["14.2", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["SC-8", "4"]
  tag "check_text": "Run the below command and ensure that each overlay network has
been encrypted.\ndocker network ls --filter driver=overlay --quiet | xargs
docker network\ninspect --format '{{.Name}} {{ .Options }}'\n"
  tag "fix": "Create overlay network with --opt encrypted flag.\n"
  tag "Default Value": "By default, data exchanged between containers on
different nodes on the overlay network\nare not encrypted in the Docker swarm
mode.\n"
end
