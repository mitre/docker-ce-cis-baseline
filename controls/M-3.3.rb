control "M-3.3" do
  title "3.3 Ensure that docker.socket file ownership is set to root:root
(Scored)"
  desc  "
    Verify that the docker.socket file ownership and group ownership is
correctly set to root.
    docker.socket file contains sensitive parameters that may alter the
behavior of Docker
    remote API. Hence, it should be owned and group-owned by root to maintain
the integrity
    of the file.

  "
  impact 0.5
  tag "severity": "medium"
  tag "cis_id": "3.3"
  tag "cis_control": ["5.1", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["AC-6(9)", "4"]
  tag "check_text": "Step 1: Find out the file location:\nsystemctl show -p
FragmentPath docker.socket\nStep 2: If the file does not exist, this
recommendation is not applicable. If the file exists,\nexecute the below
command with the correct file path to verify that the file is owned
and\ngroup-owned by root.\nFor example,\nstat -c %U:%G
/usr/lib/systemd/system/docker.socket | grep -v root:root\nThe above command
should not return anything.\n"
  tag "fix": "Step 1: Find out the file location:\nsystemctl show -p
FragmentPath docker.socket\nStep 2: If the file does not exist, this
recommendation is not applicable. If the file exists,\nexecute the below
command with the correct file path to set the ownership and group\nownership
for the file to root.\nFor example,\nchown root:root
/usr/lib/systemd/system/docker.socket\n"
  tag "Default Value": "This file may not be present on the system. In that
case, this recommendation is not\napplicable. By default, if the file is
present, the ownership and group-ownership for this file\nis correctly set to
root.\n"
  ref 'daemonsocket-option', url: 'https://docs.docker.com/engine/reference/commandline/dockerd/#daemonsocket-option'
  ref 'docker.socket', url: 'https://github.com/docker/dockerce/blob/master/components/packaging/deb/systemd/docker.socket'

  describe file(docker.socket) do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
  end
end
