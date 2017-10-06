control "M-5.8" do
  title "5.8 Ensure only needed ports are open on the container (Scored)"
  desc  "
    Dockerfile for a container image defines the ports to be opened by default
on a container
    instance. The list of ports may or may not be relevant to the application
you are running
    within the container.
    A container can be run just with the ports defined in the Dockerfile for
its image or can be
    arbitrarily passed run time parameters to open a list of ports.
Additionally, Overtime,
    Dockerfile may undergo various changes and the list of exposed ports may or
may not be
    relevant to the application you are running within the container. Opening
unneeded ports
    increase the attack surface of the container and the containerized
application. As a
    recommended practice, do not open unneeded ports.

  "
  impact 0.5
  tag "ref": "1. https://docs.docker.com/engine/userguide/networking/\n"
  tag "severity": "medium"
  tag "cis_id": "5.8"
  tag "cis_control": ["9.1", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["CM-7(1)", "4"]
  tag "check_text": "List all the running instances of containers and their port
mapping by executing the below\ncommand:\ndocker ps --quiet | xargs docker
inspect --format '{{ .Id }}: Ports={{\n.NetworkSettings.Ports }}'\nReview the
list and ensure that the ports mapped are the ones that are really needed
for\nthe container.\n"
  tag "fix": "Fix the Dockerfile of the container image to expose only needed
ports by your\ncontainerized application. You can also completely ignore the
list of ports defined in the\nDockerfile by NOT using -P (UPPERCASE) or
--publish-all flag when starting the\ncontainer. Use the -p (lowercase) or
--publish flag to explicitly define the ports that you\nneed for a particular
container instance.\nFor example,\ndocker run --interactive --tty --publish
5000 --publish 5001 --publish 5002\ncentos /bin/bash\n"
  tag "Default Value": "By default, all the ports that are listed in the
Dockerfile under EXPOSE instruction for an\nimage are opened when a container
is run with -P or --publish-all flag.\n"
  ref 'binding', url: 'https://docs.docker.com/engine/userguide/networking/default_network/binding/'
end
