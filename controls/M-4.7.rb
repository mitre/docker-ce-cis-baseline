control "M-4.7" do
  title "4.7 Ensure update instructions are not use alone in the Dockerfile (Not Scored)"
  desc  "Do not use update instructions such as apt-get update alone or in a single
  line in the Dockerfile.
  Adding the update instructions in a single line on the Dockerfile will
  cache the update layer. Thus, when you build any image later using the same instruction, 
  previously cached update layer will be used. 
  This could potentially deny any fresh updates to go in the later builds.
  "
  impact 0.5
  tag "ref": "1.
  https://docs.docker.com/engine/userguide/eng-image/dockerfile_bestpractices/#run2.
  https://github.com/docker/docker/issues/3313"
  tag "severity": "medium"
  tag "cis_id": "4.7"
  tag "cis_control": ["18", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["SI-1", "4"]
  tag "check_text": "Step 1: Run the below command to get the list of
  images: docker images Step 2: Run the below command for each image in the
  list above, and look for any update instructions being in a single
  line: docker history <Image_ID> Alternatively, if you have access to the
  Dockerfile for the image, verify that there are no update instructions as
  described above."
  tag "fix": "Use update instructions along with install instructions (or any
  other) and version pinning for packages while installing them. This would bust
  the cache and force to extract the required versions. Alternatively, you
  could use --no-cache flag during docker build process to avoid using cached
  layers."
  tag "Default Value": "By default, docker does not enforce any restrictions on
  using update instructions."

  docker.images.ids.each do |id|
    describe command("docker history #{id}| grep -e 'update'") do
      its('stdout') { should eq '' }
    end
  end
end
