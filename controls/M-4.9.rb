control "M-4.9" do
  title "4.9 Ensure COPY is used instead of ADD in Dockerfile (Not Scored)"
  desc  "
    Use COPY instruction instead of ADD instruction in the Dockerfile.
    COPY instruction just copies the files from the local host machine to the
container file
    system. ADD instruction potentially could retrieve files from remote URLs
and perform
    operations such as unpacking. Thus, ADD instruction introduces risks such
as adding
    malicious files from URLs without scanning and unpacking procedure
vulnerabilities.

  "
  impact 0.5
  tag "ref": "1.
https://docs.docker.com/engine/userguide/eng-image/dockerfile_bestpractices/#add-or-copy\n"
  tag "severity": "medium"
  tag "cis_id": "4.9"
  tag "cis_control": ["18", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["SI-1", "4"]
  tag "check_text": "Step 1: Run the below command to get the list of
images:\ndocker images\nStep 2: Run the below command for each image in the
list above and look for any ADD\ninstructions:\ndocker history
<Image_ID>\nAlternatively, if you have access to Dockerfile for the image,
verify that there are no ADD\ninstructions.\n"
  tag "fix": "Use COPY instructions in Dockerfiles.\n"
  tag "Default Value": "Not Applicable\n"
  
  docker.images.ids.each do |id|
    describe command("docker history #{id}| grep 'ADD'") do
      its('stdout') { should eq '' }
    end
  end
end
