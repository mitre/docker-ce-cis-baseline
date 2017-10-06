control "M-7.9" do
  title "7.9 Ensure CA certificates are rotated as appropriate (Not Scored)"
  desc  "
    Rotate root CA certificates as appropriate.
    Docker Swarm uses mutual TLS for clustering operations amongst its nodes.
Certificate
    rotation ensures that in an event such as compromised node or key, it is
difficult to
    impersonate a node. Node certificates depend upon root CA certificates. For
operational
    security, it is important to rotate these frequently. Currently, root CA
certificates are not
    rotated automatically. You should thus establish a process to rotate it at
the desired
    frequency.

  "
  impact 0.5
  tag "ref": "1.
https://docs.docker.com/engine/swarm/how-swarm-mode-works/pki/#rotatingthe-ca-certificate\n"
  tag "severity": "medium"
  tag "cis_id": "7.9"
  tag "cis_control": ["14.2", "6.1"]
  tag "cis_level": "Level 2 - Docker"
  tag "nist": ["SC-8", "4"]
  tag "check_text": "Based on your installation path, check the time stamp on the
root CA certificate file.\nFor example,\nls -l
/var/lib/docker/swarm/certificates/swarm-root-ca.crt\nThe certificate should
have been rotated at the established frequency.\n"
  tag "fix": "Run the below command to rotate the certificate.\ndocker swarm ca
--rotate\n"
  tag "Default Value": "By default, root CA certificates are not rotated.\n"
end
