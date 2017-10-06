control "M-3.12" do
  title "3.12 Ensure that Docker server certificate file permissions are set to
444\nor more restrictive (Scored)"
  desc  "
    Verify that the Docker server certificate file (the file that is passed
alongwith --tlscert
    parameter) has permissions of 444 or more restrictive.
    The Docker server certificate file should be protected from any tampering.
It is used to
    authenticate Docker server based on the given server certificate. Hence, it
must have
    permissions of 444 to maintain the integrity of the certificate.

  "
  impact 0.5
  tag "ref": "1. https://docs.docker.com/registry/insecure/\n2.
https://docs.docker.com/engine/security/https/\n"
  tag "severity": "medium"
  tag "cis_id": "3.12"
  tag "cis_control": ["14.4", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["AC-3 (3)", "4"]
  tag "check_text": "Execute the below command to verify that the Docker server
certificate file has\npermissions of 444 or more restrictive:\nstat -c %a <path
to Docker server certificate file>\n"
  tag "fix": "chmod 444 <path to Docker server certificate file>\nThis would
set the file permissions of the Docker server file to 444.\n"
  tag "Default Value": "By default, the permissions for Docker server
certificate file might not be 444. The default\nfile permissions are governed
by the system or user specific umask values.\n"
  ref url: 'https://docs.docker.com/engine/security/certificates/'
  ref url: 'https://docs.docker.com/engine/security/https/'

  describe file(json('/etc/docker/daemon.json').params['tlscert']) do
    it { should exist }
    it { should be_file }
    it { should be_readable }
    it { should_not be_executable }
    it { should_not be_writable }
  end
end
