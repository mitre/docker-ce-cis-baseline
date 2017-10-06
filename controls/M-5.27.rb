control "M-5.27" do
  title "5.27 Ensure docker commands always get the latest version of
the\nimage (Not Scored)"
  desc  "
    Always ensure that you are using the latest version of the image within
your repository and
    not the cached older versions.
    Multiple docker commands such as docker pull, docker run, etc. are known to
have an
    issue that by default, they extract the local copy of the image, if
present, even though there
    is an updated version of the image with the \"same tag\" in the upstream
repository. This
    could lead to using older and vulnerable images.

  "
  impact 0.5
  tag "ref": "1. https://github.com/docker/docker/pull/16609\n"
  tag "severity": "medium"
  tag "cis_id": "5.27"
  tag "cis_control": ["18.1", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["SI-2", "4"]
  tag "check_text": "Step 1: Open your image repository and list the image version
history for the image you\nare inspecting.\nStep 2: Observe the status when the
docker pull command is triggered.\nIf the status is shown as Image is up to
date, it means that you are getting the cached\nversion of the image.\nStep 3:
Match the version of the image you are running with the latest version reported
in\nyour repository which tells if you are running the cached version or the
latest copy.\n"
  tag "fix": "Use proper version pinning mechanisms (the latest tag which is
assigned by default is still\nvulnerable to caching attacks) to avoid
extracting the cached older versions. Version\npinning mechanisms should be
used for base images, packages, and entire images too. You\ncan customize
version pinning rules as per your requirements.\n"
  tag "Default Value": "By default, docker commands extract the local copy
unless version pinning mechanisms are\nused or the local cache is cleared.\n"

  describe 'docker-test' do
    skip 'Not implemented yet'
  end
end
