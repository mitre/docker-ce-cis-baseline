control "M-3.9" do
  title "3.9 Ensure that TLS CA certificate file ownership is set to
root:root(Scored)"
  desc  "
    Verify that the TLS CA certificate file (the file that is passed alongwith
--tlscacert
    parameter) is owned and group-owned by root.
    The TLS CA certificate file should be protected from any tampering. It is
used to
    authenticate Docker server based on given CA certificate. Hence, it must be
owned and
    group-owned by root to maintain the integrity of the CA certificate.

  "
  impact 0.5
  tag "ref": "1. https://docs.docker.com/registry/insecure/\n2.
https://docs.docker.com/engine/security/https/\n"
  tag "severity": "medium"
  tag "cis_id": "3.9"
  tag "cis_control": ["5.1", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["AC-6(9)", "4"]
  tag "check_text": "Execute the below command to verify that the TLS CA certificate
file is owned and groupowned by root:\nstat -c %U:%G <path to TLS CA
certificate file> | grep -v root:root\nThe above command should not return
anything.\n"
  tag "fix": "chown root:root <path to TLS CA certificate file>\nThis would set
the ownership and group-ownership for the TLS CA certificate file to root.\n"
  tag "Default Value": "By default, the ownership and group-ownership for TLS
CA certificate file is correctly set to\nroot.\n"
  ref url: 'https://docs.docker.com/engine/security/certificates/'
  ref url: 'https://docs.docker.com/engine/security/https/'

  json('/etc/docker/daemon.json').params['tlscacert']

  describe file(json('/etc/docker/daemon.json').params['tlscacert']) do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end
