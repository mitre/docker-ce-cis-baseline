control "M-3.14" do
  title "3.14 Ensure that Docker server certificate key file permissions are
set to\n400 (Scored)"
  desc  "
    Verify that the Docker server certificate key file (the file that is passed
alongwith --tlskey
    parameter) has permissions of 400.
    The Docker server certificate key file should be protected from any
tampering or unneeded
    reads. It holds the private key for the Docker server certificate. Hence,
it must have
    permissions of 400 to maintain the integrity of the Docker server
certificate.

  "
  impact 0.5
  tag "ref": "1. https://docs.docker.com/registry/insecure/\n2.
https://docs.docker.com/engine/security/https/\n"
  tag "severity": "medium"
  tag "cis_id": "3.14"
  tag "cis_control": ["14.4", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["AC-3 (3)", "4"]
  tag "check_text": "Execute the below command to verify that the Docker server
certificate key file has\npermissions of 400:\nstat -c %a <path to Docker
server certificate key file>\n"
  tag "fix": "chmod 400 <path to Docker server certificate key file>\nThis
would set the Docker server certificate key file permissions to 400.\n"
  tag "Default Value": "By default, the permissions for Docker server
certificate key file might not be 400. The\ndefault file permissions are
governed by the system or user specific umask values.\n"
  ref url: 'https://docs.docker.com/engine/security/certificates/'
  ref url: 'https://docs.docker.com/engine/security/https/'

  describe file(json('/etc/docker/daemon.json').params['tlskey']) do
    it { should exist }
    it { should be_file }
    it { should be_readable }
    it { should_not be_executable }
    it { should_not be_writable }
  end
end
