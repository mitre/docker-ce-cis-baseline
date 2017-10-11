control "M-3.4" do
  title "3.4 Ensure that docker.socket file permissions are set to 644 or
more\nrestrictive (Scored)"
  desc  "
    Verify that the docker.socket file permissions are correctly set to 644 or
more restrictive.
    docker.socket file contains sensitive parameters that may alter the
behavior of Docker
    remote API. Hence, it should be writable only by root to maintain the
integrity of the file.

  "
  impact 0.5
  tag "severity": "medium"
  tag "cis_id": "3.4"
  tag "cis_control": ["14.4", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["AC-3 (3)", "4"]
  tag "check_text": "Step 1: Find out the file location:\nsystemctl show -p
FragmentPath docker.socket\nStep 2: If the file does not exist, this
recommendation is not applicable. If the file exists,\nexecute the below
command with the correct file path to verify that the file permissions are\nset
to 644 or more restrictive.\nFor example,\nstat -c %a
/usr/lib/systemd/system/docker.socket\n"
  tag "fix": "Step 1: Find out the file location:\nsystemctl show -p
FragmentPath docker.socket\nStep 2: If the file does not exist, this
recommendation is not applicable. If the file exists,\nexecute the below
command with the correct file path to set the file permissions to 644.\nFor
example,\nchmod 644 /usr/lib/systemd/system/docker.socket\n"
  tag "Default Value": "This file may not be present on the system. In that
case, this recommendation is not\napplicable. By default, if the file is
present, the file permissions for this file are correctly set\nto 644.\n"
  ref 'quickstart', url: 'https://docs.docker.com/engine/quickstart/'
  ref 'bind-dockerto-another-hostport-or-a-unix-socket', url: 'https://docs.docker.com/engine/reference/commandline/dockerd/#bind-dockerto-another-hostport-or-a-unix-socket'
  ref 'docker.socker', url: 'https://github.com/YungSang/fedora-atomic-packer/blob/master/oem/docker.socket'
  ref 'centos-7rhel-7-and-docker-containers-on-boot', url: 'https://daviddaeschler.com/2014/12/14/centos-7rhel-7-and-docker-containers-on-boot/'

  describe file(docker.socket) do
    it { should exist }
    it { should be_file }
    it { should be_readable.by('owner') }
    it { should be_writable.by('owner') }
    it { should be_readable.by('group') }
    it { should_not be_writable.by('group') }
    it { should be_readable.by('other') }
    it { should_not be_writable.by('other') }
    it { should_not be_executable }
  end
end
