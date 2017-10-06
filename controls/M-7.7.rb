control "M-7.7" do
  title "7.7 Ensure swarm manager auto-lock key is rotated periodically
(Not\nScored)"
  desc  "
    Rotate swarm manager auto-lock key periodically.
    Swarm manager auto-lock key is not automatically rotated. You should rotate
them
    periodically as a best practice.

  "
  impact 0.5
  tag "ref": "1.
https://docs.docker.com/engine/reference/commandline/swarm_unlock-key/\n"
  tag "severity": "medium"
  tag "cis_id": "7.7"
  tag "cis_control": ["14.2", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["SC-8", "4"]
  tag "check_text": "Currently, there is no mechanism to find out when the key was
last rotated on a swarm\nmanager node. You should check with the system
administrator if there is a key rotation\nrecord and the keys were rotated at a
pre-defined frequency.\n"
  tag "fix": "Run the below command to rotate the keys.\ndocker swarm
unlock-key --rotate\nAdditionally, to facilitate audit for this recommendation,
maintain key rotation records and\nensure that you establish a pre-defined
frequency for key rotation.\n"
  tag "Default Value": "By default, keys are not rotated automatically.\n"
end
