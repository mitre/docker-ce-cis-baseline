# attributes
CONTAINER_USER = attribute(
  'container_user',
  description: 'define user within containers. cis-docker-benchmark-4.1',
  default: 'ubuntu'
)

control "M-4.1" do
  title "4.1 Ensure a user for the container has been created (Scored)"
  desc  "
    Create a non-root user for the container in the Dockerfile for the
container image.
    It is a good practice to run the container as a non-root user, if possible.
Though user
    namespace mapping is now available, if a user is already defined in the
container image, the
    container is run as that user by default and specific user namespace
remapping is not
    required.

  "
  impact 0.5
  tag "ref": "1. https://github.com/docker/docker/issues/2918\n2.
https://github.com/docker/docker/pull/4572\n3.
https://github.com/docker/docker/issues/7906\n"
  tag "severity": "medium"
  tag "cis_id": "4.1"
  tag "cis_control": ["5.1", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["AC-6(9)", "4"]
  tag "check_text": "docker ps --quiet --all | xargs docker inspect --format '{{ .Id
}}: User={{\n.Config.User }}'\nThe above command should return container
username or user ID. If it is blank it means,\nthe container is running as
root.\n"
  tag "fix": "Ensure that the Dockerfile for the container image contains below
instruction:\nUSER <username or ID>\nwhere username or ID refers to the user
that could be found in the container base image. If\nthere is no specific user
created in the container base image, then add a useradd command\nto add the
specific user before USER instruction.\nFor example, add the below lines in the
Dockerfile to create a user in the container:\nRUN useradd -d /home/username -m
-s /bin/bash username\nUSER username\nNote: If there are users in the image
that the containers do not need, consider deleting\nthem. After deleting those
users, commit the image and then generate new instances of\ncontainers for
use.\n"
  tag "Default Value": "By default, the containers are run with rootprivileges
and as user rootinside the container.\n"
  ref url: 'https://github.com/docker/docker/issues/2918'
  ref url: 'https://github.com/docker/docker/pull/4572'
  ref url: 'https://github.com/docker/docker/issues/7906'
  ref url: 'https://www.altiscale.com/blog/making-docker-work-yarn/'

  docker.containers.running?.ids.each do |id|
    describe docker.object(id) do
      its(%w(Config User)) { should_not eq nil }
      its(%w(Config User)) { should eq CONTAINER_USER }
    end
  end
end
