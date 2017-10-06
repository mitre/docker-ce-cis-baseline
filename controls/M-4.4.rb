control "M-4.4" do
  title "4.4 Ensure images are scanned and rebuilt to include security
patches(Not Scored)"
  desc  "
    Images should be scanned \"frequently\" for any vulnerabilities. Rebuild
the images to
    include patches and then instantiate new containers from it.
    Vulnerabilities are loopholes/bugs that can be exploited and security
patches are updates
    to resolve these vulnerabilities. We can use image vulnerability scanning
tools to find any
    kind of vulnerabilities within the images and then check for available
patches to mitigate
    these vulnerabilities. Patches update the system to the most recent code
base. Being on the
    current code base is important because that's where vendors focus on fixing
problems.
    Evaluate the security patches before applying and follow the patching best
practices.
    Also, it would be better if, image vulnerability scanning tools could
perform binary level
    analysis or hash based verification instead of just version string matching.

  "
  impact 0.5
  tag "ref":
"1.\n2.\n3.\n4.\nhttps://docs.docker.com/userguide/dockerimages/\nhttps://docs.docker.com/docker-cloud/builds/image-scan/\nhttps://blog.docker.com/2016/05/docker-security-scanning/\nhttps://docs.docker.com/engine/reference/builder/#/onbuild\n"
  tag "severity": "medium"
  tag "cis_id": "4.4"
  tag "cis_control": ["18.1", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["SI-2", "4"]
  tag "check_text": "Step 1: List all the running instances of containers by
executing below command:\ndocker ps --quiet\nStep 2: For each container
instance, execute the below or equivalent command to find the\nlist of packages
installed within the container. Ensure that the security updates for
various\naffected packages are installed.\ndocker exec $INSTANCE_ID rpm
-qa\nAlternatively, you could run image vulnerability scanning tools which can
scan all the\nimages in your ecosystem and then apply patches for the detected
vulnerabilities based on\nyour patch management procedures.\n"
  tag "fix": "Follow the below steps to rebuild the images with security
patches:\nStep 1: Pull all the base images (i.e., given your set of
Dockerfiles, extract all images\ndeclared in FROM instructions, and re-pull
them to check for an updated/patched versions).\nPatch the packages within the
images too.\ndocker pull\nStep 2: Force a rebuild of each image:\ndocker build
--no-cache\nStep 3: Restart all containers with the updated images.\nYou could
also use ONBUILD directive in the Dockerfile to trigger particular
update\ninstructions for images that you know are used as base images
frequently.\n"
  tag "Default Value": "By default, containers and images are not updated of
their own.\n"
  ref url: 'https://docs.docker.com/engine/userguide/containers/dockerimages/'
end
