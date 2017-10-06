control "M-5.7" do
  title "5.7 Ensure privileged ports are not mapped within containers (Scored)"
  desc  "
    The TCP/IP port numbers below 1024are considered privileged ports. Normal
users and
    processes are not allowed to use them for various security reasons. Docker
allows a
    container port to be mapped to a privileged port.
    By default, if the user does not specifically declare the container port to
host port mapping,
    Docker automatically and correctly maps the container port to one available
in 4915365535 block on the host. But, Docker allows a container port to be
mapped to a privileged
    port on the host if the user explicitly declared it. This is so because
containers are executed
    with NET_BIND_SERVICE Linux kernel capability that does not restrict the
privileged port
    mapping. The privileged ports receive and transmit various sensitive and
privileged data.
    Allowing containers to use them can bring serious implications.

  "
  impact 0.5
  tag "ref": "1. https://docs.docker.com/engine/userguide/networking/\n"
  tag "severity": "medium"
  tag "cis_id": "5.7"
  tag "cis_control": ["9.1", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["CM-7(1)", "4"]
  tag "check_text": "List all running containers instances and their port mapping by
executing the below\ncommand:\ndocker ps --quiet | xargs docker inspect
--format '{{ .Id }}: Ports={{\n.NetworkSettings.Ports }}'\nReview the list and
ensure that container ports are not mapped to host port numbers\nbelow 1024.\n"
  tag "fix": "Do not map the container ports to privileged host ports when
starting a container. Also,\nensure that there is no such container to host
privileged port mapping declarations in the\nDockerfile.\n"
  tag "Default Value": "By default, mapping a container port to a privileged
port on the host is allowed.\nNote: There might be certain cases where you want
to map privileged ports, because if you\nforbid it, then the corresponding
application has to run outside of a container.\nFor example: HTTP and HTTPS
load balancers have to bind 80/tcp and 443/tcp\nrespectively. Forbidding to map
privileged ports effectively forbids from running those in a\ncontainer, and
mandates using an external load balancer. In such cases, those
containers\ninstances should be marked as exceptions for this recommendation.\n"
  ref url: 'https://docs.docker.com/engine/userguide/networking/default_network/binding/'
  ref url: 'https://www.adayinthelifeof.nl/2012/03/12/why-putting-ssh-on-another-port-than-22-is-bad-idea/'

  docker.containers.running?.ids.each do |id|
    container_info = docker.object(id)
    next if container_info['NetworkSettings']['Ports'].nil?
    container_info['NetworkSettings']['Ports'].each do |_, hosts|
      hosts.each do |host|
        describe host['HostPort'].to_i.between?(1, 1024) do
          it { should eq false }
        end
      end
    end
  end
end
