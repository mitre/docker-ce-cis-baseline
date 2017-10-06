control "M-7.5" do
  title "7.5 Ensure Docker's secret management commands are used for\nmanaging
secrets in a Swarm cluster (Not Scored)"
  desc  "
    Use Docker's in-built secret management command.
    Docker has various commands for managing secrets in a Swarm cluster. This
is the
    foundation for future secret support in Docker with potential improvements
such as
    Windows support, different backing stores, etc.

  "
  impact 0.5
  tag "ref": "1. https://docs.docker.com/engine/reference/commandline/secret/\n"
  tag "severity": "medium"
  tag "cis_id": "7.5"
  tag "cis_control": ["18", "6.1"]
  tag "cis_level": "Level 2 - Docker"
  tag "nist": ["SI-1", "4"]
  tag "check_text": "On a swarm manager node, run the below command and ensure
docker secret\nmanagement is used in your environment, if applicable.\ndocker
secret ls\n"
  tag "fix": "Follow docker secret documentation and use it to manage secrets
effectively.\n"
  tag "Default Value": "Not Applicable\n"
end
