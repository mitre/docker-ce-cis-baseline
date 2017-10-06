control "M-4.8" do
  title "4.8 Ensure setuid and setgid permissions are removed in the images(Not
Scored)"
  desc  "
    Removing setuid and setgid permissions in the images would prevent
privilege escalation
    attacks in the containers.
    setuid and setgid permissions could be used for elevating privileges. While
these
    permissions are at times legitimately needed, these could potentially be
used in privilege
    escalation attacks. Thus, you should consider dropping these permissions
for the packages
    which do not need them within the images.

  "
  impact 0.5
  tag "ref": "1.
http://www.oreilly.com/webops-perf/free/files/docker-security.pdf\n2.
http://containersolutions.com/content/uploads/2015/06/15.06.15_DockerCheatSheet_A2.pdf\n3.
http://man7.org/linux/man-pages/man2/setuid.2.html\n4.
http://man7.org/linux/man-pages/man2/setgid.2.html\n"
  tag "severity": "medium"
  tag "cis_id": "4.8"
  tag "cis_control": ["5.1", "6.1"]
  tag "cis_level": "Level 2 - Docker"
  tag "nist": ["AC-6(9)", "4"]
  tag "check_text": "Run the below command on the image to list the executables
having setuid and setgid\npermissions:\ndocker run <Image_ID> find / -perm
+6000 -type f -exec ls -ld {} \\; 2>\n/dev/null\nCarefully, review the list and
ensure that it is legitimate.\n"
  tag "fix": "Allow setuid and setgid permissions only on executables which
need them. You could\nremove these permissions during build time by adding the
following command in your\nDockerfile, preferably towards the end of the
Dockerfile:\nRUN find / -perm +6000 -type f -exec chmod a-s {} \\; || true\n"
  tag "Default Value": "Not Applicable\n"
  ref url: 'https://github.com/dev-sec/linux-baseline'

  describe 'docker-test' do
    skip 'Use DevSec Linux Baseline in Container'
  end
end
