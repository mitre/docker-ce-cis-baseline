control "M-4.3" do
  title "4.3 Ensure unnecessary packages are not installed in the container
(Not\nScored)"
  desc  "
    Containers tend to be minimal and slim down versions of the Operating
System. Do not
    install anything that does not justify the purpose of container.
    Bloating containers with unnecessary software could possibly increase the
attack surface
    of the container. This also voids the concept of minimal and slim down
versions of
    container images. Hence, do not install anything else apart from what is
truly needed for
    the purpose of the container.

  "
  impact 0.5
  tag "ref": "1. https://docs.docker.com/userguide/dockerimages/\n2.
http://www.livewyer.com/blog/2015/02/24/slimming-down-your-dockercontainers-alpine-linux\n3.
https://github.com/progrium/busybox\n"
  tag "severity": "medium"
  tag "cis_id": "4.3"
  tag "cis_control": ["18", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["SI-1", "4"]
  tag "check_text": "Step 1: List all the running instances of containers by
executing below command:\ndocker ps --quiet\nStep 2: For each container
instance, execute the below or equivalent command:\ndocker exec $INSTANCE_ID
rpm -qa\nThe above command would list the packages installed on the container.
Review the list and\nensure that it is legitimate.\n"
  tag "fix": "At the outset, do not install anything on the container that does
not justify the purpose. If\nthe image had some packages that your container
does not use, uninstall them.\nConsider using a minimal base image rather than
the standard Redhat/Centos/Debian\nimages if you can. Some of the options
include BusyBox and Alpine.\nNot only does this trim your image size from
>150Mb to ~20 Mb, there are also fewer tools\nand paths to escalate privileges.
You can even remove the package installer as a final\nhardening measure for
leaf/production containers.\n"
  tag "Default Value": "Not Applicable.\n"
  ref url: 'https://docs.docker.com/engine/userguide/containers/dockerimages/'
  ref url: 'http://www.livewyer.com/blog/2015/02/24/slimming-down-your-docker-containers-alpine-linux'
  ref url: 'https://github.com/progrium/busybox'
end
