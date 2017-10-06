control "M-5.13" do
  title "5.13 Ensure incoming container traffic is binded to a specific
host\ninterface (Scored)"
  desc  "
    By default, Docker containers can make connections to the outside world,
but the outside
    world cannot connect to containers. Each outgoing connection will appear to
originate
    from one of the host machine's own IP addresses. Only allow container
services to be
    contacted through a specific external interface on the host machine.
    If you have multiple network interfaces on your host machine, the container
can accept
    connections on the exposed ports on any network interface. This might not
be desired and
    may not be secured. Many a times a particular interface is exposed
externally and services
    such as intrusion detection, intrusion prevention, firewall, load
balancing, etc. are run on
    those interfaces to screen incoming public traffic. Hence, you should not
accept incoming
    connections on any interface. You should only allow incoming connections
from a
    particular external interface.

  "
  impact 0.5
  tag "ref": "1. https://docs.docker.com/engine/userguide/networking/\n"
  tag "severity": "medium"
  tag "cis_id": "5.13"
  tag "cis_control": ["9", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["SC-7", "4"]
  tag "check_text": "List all the running instances of containers and their port
mapping by executing the below\ncommand:\ndocker ps --quiet | xargs docker
inspect --format '{{ .Id }}: Ports={{\n.NetworkSettings.Ports }}'\nReview the
list and ensure that the exposed container ports are tied to a
particular\ninterface and not to the wildcard IP address - 0.0.0.0.\nFor
example, if the above command returns as below, then this is non-compliant and
the\ncontainer can accept connections on any host interface on the specified
port 49153.\nPorts=map[443/tcp:<nil> 80/tcp:[map[HostPort:49153
HostIp:0.0.0.0]]]\nHowever, if the exposed port is tied to a particular
interface on the host as below, then this\nrecommendation is configured as
desired and is compliant.\nPorts=map[443/tcp:<nil> 80/tcp:[map[HostIp:10.2.3.4
HostPort:49153]]]\n"
  tag "fix": "Bind the container port to a specific host interface on the
desired host port.\nFor example,\ndocker run --detach --publish
10.2.3.4:49153:80 nginx\nIn the example above, the container port 80 is bound
to the host port on 49153 and would\naccept incoming connection only from
10.2.3.4 external interface.\n"
  tag "Default Value": "By default, Docker exposes the container ports on
0.0.0.0, the wildcard IP address that\nwill match any possible incoming network
interface on the host machine.\n"
  ref url: 'https://docs.docker.com/engine/userguide/networking/default_network/binding/'

  docker.containers.running?.ids.each do |id|
    container_info = docker.object(id)
    next if container_info['NetworkSettings']['Ports'].nil?
    container_info['NetworkSettings']['Ports'].each do |_, hosts|
      hosts.each do |host|
        describe host['HostIp'].to_i.between?(1, 1024) do
          it { should_not eq '0.0.0.0' }
        end
      end
    end
  end
end
