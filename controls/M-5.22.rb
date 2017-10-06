control "M-5.22" do
  title "5.22 Ensure docker exec commands are not used with privileged
option(Scored)"
  desc  "
    Do not docker exec with --privileged option.
    Using --privileged option in docker exec gives extended Linux capabilities
to the
    command. This could potentially be insecure and unsafe to do especially
when you are
    running containers with dropped capabilities or with enhanced restrictions.

  "
  impact 0.5
  tag "ref": "1. https://docs.docker.com/engine/reference/commandline/exec/\n"
  tag "severity": "medium"
  tag "cis_id": "5.22"
  tag "cis_control": ["5.1", "6.1"]
  tag "cis_level": "Level 2 - Docker"
  tag "nist": ["AC-6(9)", "4"]
  tag "check_text": "If you have auditing enabled as prescribed in Section 1, you
can use the below command to\nfilter out docker exec commands that used
--privileged option.\nausearch -k docker | grep exec | grep privileged\n"
  tag "fix": "Do not use --privileged option in docker exec command.\n"
  tag "Default Value": "By default, docker exec command runs without
--privileged option.\n"
  ref url: 'https://docs.docker.com/engine/reference/commandline/exec/'

  describe command('ausearch --input-logs -k docker | grep exec | grep privileged').stdout do
    it { should be_empty }
  end
end
