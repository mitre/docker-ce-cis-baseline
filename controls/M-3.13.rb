control "M-3.13" do
  title "3.13 Ensure that Docker server certificate key file ownership is set
to\nroot:root (Scored)"
  desc  "
    Verify that the Docker server certificate key file (the file that is passed
alongwith --tlskey
    parameter) is owned and group-owned by root.
    The Docker server certificate key file should be protected from any
tampering or unneeded
    reads. It holds the private key for the Docker server certificate. Hence,
it must be owned
    and group-owned by root to maintain the integrity of the Docker server
certificate.

  "
  impact 0.5
  tag "ref": "1. https://docs.docker.com/registry/insecure/\n2.
https://docs.docker.com/engine/security/https/\n"
  tag "severity": "medium"
  tag "cis_id": "3.13"
  tag "cis_control": ["5.1", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["AC-6(9)", "4"]
  tag "check_text": "Execute the below command to verify that the Docker server
certificate key file is owned\nand group-owned by root:\nstat -c %U:%G <path to
Docker server certificate key file> | grep -v\nroot:root\nThe above command
should not return anything.\n"
  tag "fix": "chown root:root <path to Docker server certificate key
file>\nThis would set the ownership and group-ownership for the Docker server
certificate key\nfile to root.\n"
  tag "Default Value": "By default, the ownership and group-ownership for
Docker server certificate key file is\ncorrectly set to root.\n"
  ref url: 'https://docs.docker.com/engine/security/certificates/'
  ref url: 'https://docs.docker.com/engine/security/https/'

  describe file(json('/etc/docker/daemon.json').params['tlskey']) do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end
