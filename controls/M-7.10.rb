control "M-7.10" do
  title "7.10 Ensure management plane traffic has been separated from
data\nplane traffic (Not Scored)"
  desc  "
    Separate management plane traffic from data plane traffic.
    Separating the management plane traffic from data plane traffic ensures
that these traffics
    are on their respective paths. These paths could then be individually
monitored and could
    be tied to different traffic control policies and monitoring. It also
ensures that management
    plane is always reachable despite the huge volume of data flow.

  "
  impact 0.5
  tag "ref": "1.
https://docs.docker.com/engine/reference/commandline/swarm_init/#--datapath-addr\n2.
https://github.com/moby/moby/issues/33938\n3.
https://github.com/moby/moby/pull/32717\n"
  tag "severity": "medium"
  tag "cis_id": "7.10"
  tag "cis_control": ["18", "6.1"]
  tag "cis_level": "Level 2 - Docker"
  tag "nist": ["SI-1", "4"]
  tag "check_text": "Run the below command on each swarm node and ensure that the
management plane\naddress is different from data plane address.\ndocker node
inspect\n--format '{{ .Status.Addr }}' self\nNote: At the time of writing of
this benchmark, there is no way to inspect data plane\naddress. An issue has
been raised and is in the reference link.\n"
  tag "fix": "Initialize Swarm with dedicated interfaces for management and
data planes respectively.\nFor example,\ndocker swarm init
--advertise-addr=192.168.0.1 --data-path-addr=17.1.0.3\n"
  tag "Default Value": "By default, the data plane traffic is not separated
from management plane traffic.\n"
end
