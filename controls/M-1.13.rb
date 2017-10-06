control "M-1.13" do
  title "1.13 Ensure auditing is configured for Docker files and directories
/usr/bin/docker-runc (Scored)"
  desc  "
    Audit /usr/bin/docker-runc, if applicable.
    Apart from auditing your regular Linux file system and system calls, audit
all Docker
    related files and directories. Docker daemon runs with root privileges. Its
behavior
    depends on some key files and directories. /usr/bin/docker-runc is one such
file. Docker
    now relies on containerd and runC to spawn containers. It must be audited,
if applicable.

  "
  impact 0.5
  tag "severity": "medium"
  tag "cis_id": "1.13"
  tag "cis_control": ["14.6", "6.1"]
  tag "cis_level": "Level 1 - Linux Host OS"
  tag "nist": ["AU-2", "4"]
  tag "check_text": "Verify that there is an audit rule corresponding to
/usr/bin/docker-runc file.\nFor example, execute below command:\nauditctl -l |
grep /usr/bin/docker-runc\nThis should list a rule for /usr/bin/docker-runc
file.\n"
  tag "fix": "Add a rule for /usr/bin/docker-runc file.\nFor example,\nAdd the
line as below in /etc/audit/audit.rules file:\n-w /usr/bin/docker-runc -k
docker\nThen, restart the audit daemon. For example,\nservice auditd restart\n"
  tag "Default Value": "By default, Docker related files and directories are
not audited. The file/usr/bin/dockerrunc may not be available on the system. In
that case, this recommendation is not\napplicable.\n"
  ref 'System auditing', url: 'https://access.redhat.com/documentation/en-US/Red_Hat_Enterprise_Linux/6/html/Security_Guide/chap-system_auditing.html'
  ref 'Containerd integration', url: 'https://github.com/docker/docker/pull/20662'
  ref 'Containerd tools', url: 'https://containerd.tools/'
  ref 'Opencontainers runc repository', url: 'https://github.com/opencontainers/runc'

  only_if { os.linux? }
  describe auditd_rules do
    its(:lines) { should include('-w /usr/bin/docker-runc -p rwxa -k docker') }
  end
end
