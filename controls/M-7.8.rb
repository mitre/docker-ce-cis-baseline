control "M-7.8" do
  title "7.8 Ensure node certificates are rotated as appropriate (Not Scored)"
  desc  "
    Rotate swarm node certificates as appropriate.
    Docker Swarm uses mutual TLS for clustering operations amongst its nodes.
Certificate
    rotation ensures that in an event such as compromised node or key, it is
difficult to
    impersonate a node. By default, node certificates are rotated every 90
days. You should
    rotate it more often or as appropriate in your environment.

  "
  impact 0.5
  tag "ref": "1.
https://docs.docker.com/engine/reference/commandline/swarm_update/#exampl\nes\n"
  tag "severity": "medium"
  tag "cis_id": "7.8"
  tag "cis_control": ["14.2", "6.1"]
  tag "cis_level": "Level 2 - Docker"
  tag "nist": ["SC-8", "4"]
  tag "check_text": "Run the below command and ensure that the node certificate
Expiry Duration is set as\nappropriate.\ndocker info | grep \"Expiry
Duration\"\n"
  tag "fix": "Run the below command to set the desired expiry time.\nFor
example,\ndocker swarm update --cert-expiry 48h\n"
  tag "Default Value": "By default, node certificates are rotated automatically
every 90 days.\n"
end
