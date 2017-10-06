control "M-5.23" do
  title "5.23 Ensure docker exec commands are not used with user option(Scored)"
  desc  "
    Do not docker exec with --user option.
    Using --user option in docker exec executes the command within the
container as that
    user. This could potentially be insecure and unsafe to do especially when
you are running
    containers with dropped capabilities or with enhanced restrictions.
    For example, suppose your container is running as tomcat user (or any other
non-root
    user), it would be possible to run a command through docker exec as
rootwith -user=root option. This could potentially be dangerous.

  "
  impact 0.5
  tag "ref": "1. https://docs.docker.com/engine/reference/commandline/exec/\n"
  tag "severity": "medium"
  tag "cis_id": "5.23"
  tag "cis_control": ["5", "6.1"]
  tag "cis_level": "Level 2 - Docker"
  tag "nist": ["AC-6", "4"]
  tag "check_text": "If you have auditing enabled as prescribed in Section 1, you
can use the below command to\nfilter out docker exec commands that used --user
option.\nausearch -k docker | grep exec | grep user\n"
  tag "fix": "Do not use --user option in docker exec command.\n"
  tag "Default Value": "By default, docker exec command runs without --user
option.\n"
  ref url: 'https://docs.docker.com/engine/reference/commandline/exec/'

  describe command('ausearch --input-logs -k docker | grep exec | grep user').stdout do
    it { should be_empty }
  end
end
