control "M-1.11" do
  title "1.11 Ensure auditing is configured for Docker files and directories
/etc/docker/daemon.json (Scored)"
  desc  "
    Audit /etc/docker/daemon.json, if applicable.
    Apart from auditing your regular Linux file system and system calls, audit
all Docker
    related files and directories. Docker daemon runs with root privileges. Its
behavior
    depends on some key files and directories. /etc/docker/daemon.json is one
such file. It
    holds various parameters for Docker daemon. It must be audited, if
applicable.

  "
  impact 0.5
  tag "severity": "medium"
  tag "cis_id": "1.11"
  tag "cis_control": ["14.6", "6.1"]
  tag "cis_level": "Level 1 - Linux Host OS"
  tag "nist": ["AU-2", "4"]
  tag "check_text": "Verify that there is an audit rule corresponding to
/etc/docker/daemon.json file.\nFor example, execute below command:\nauditctl -l
| grep /etc/docker/daemon.json\nThis should list a rule for
/etc/docker/daemon.json file.\n"
  tag "fix": "Add a rule for /etc/docker/daemon.json file.\nFor example,\nAdd
the line as below in /etc/audit/audit.rules file:\n-w /etc/docker/daemon.json
-k docker\nThen, restart the audit daemon. For example,\nservice auditd
restart\n"
  tag "Default Value": "By default, Docker related files and directories are
not audited. The file\n/etc/docker/daemon.json may not be available on the
system. In that case, this\nrecommendation is not applicable.\n"
  ref 'System auditing', url: 'https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Security_Guide/chap-system_auditing.html'
  ref 'daemonconfiguration-file', url: 'https://docs.docker.com/engine/reference/commandline/dockerd/#daemonconfiguration-file'
  ref 'Daemon configuration', url: 'https://docs.docker.com/engine/reference/commandline/daemon/#daemon-configuration-file'

  only_if { os.linux? }
  describe auditd_rules do
    its(:lines) { should include('-w /etc/docker/daemon.json -p rwxa -k docker') }
  end
end
