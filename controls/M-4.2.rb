control "M-4.2" do
  title "4.2 Ensure that containers use trusted base images (Not Scored)"
  desc  "
    Ensure that the container image is written either from scratch or is based
on another
    established and trusted base image downloaded over a secure channel.
    Official repositories are Docker images curated and optimized by the Docker
community or
    the vendor. There could be other potentially unsafe public repositories.
Caution should be
    exercised when obtaining container images from Docker and third parties to
how they will
    be used for your organization's data.

  "
  impact 0.5
  tag "ref": "1. https://titanous.com/posts/docker-insecurity\n2.
https://registry.hub.docker.com/\n3.
http://blog.docker.com/2014/10/docker-1-3-signed-images-process-injectionsecurity-options-mac-shared-directories/\n4.
https://github.com/docker/docker/issues/8093\n5.
https://docs.docker.com/engine/reference/commandline/pull/\n6.
https://github.com/docker/docker/pull/11109\n7.
https://blog.docker.com/2015/11/docker-trusted-registry-1-4/\n"
  tag "severity": "medium"
  tag "cis_id": "4.2"
  tag "cis_control": ["3", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["CM-6", "4"]
  tag "check_text": "Step 1 - Inspect the Docker host for Docker images used by
executing the below command:\ndocker images\nThis would list all the container
images that are currently available for use on the Docker\nhost. Interview the
system administrator and obtain a proof of evidence that the list of\nimages
was obtained from trusted source over a secure channel or from a trusted,
secure\nprivate Docker registry.\nStep 2 - For each Docker image found on the
Docker host, inspect the image for how it was\nbuilt to verify if from trusted
sources and hardened configuration:\ndocker history <imageName>\n"
  tag "fix": "\n\n\nConfigure and use Docker Content trust.\nInspect Docker
image history to evaluate their risk to operate on your network.\nScan Docker
images for vulnerabilities in their dependencies and configurations\nthey will
impose upon your network.\n"
  tag "Default Value": "Not Applicable.\n"
  ref url: 'https://titanous.com/posts/docker-insecurity'
  ref url: 'https://hub.docker.com/'
  ref url: 'https://blog.docker.com/2014/10/docker-1-3-signed-images-process-injection-security-options-mac-shared-directories/'
  ref url: 'https://github.com/docker/docker/issues/8093'
  ref url: 'https://docs.docker.com/engine/reference/commandline/cli/#pull'
  ref url: 'https://github.com/docker/docker/pull/11109'
  ref url: 'https://blog.docker.com/2015/11/docker-trusted-registry-1-4/'
end
