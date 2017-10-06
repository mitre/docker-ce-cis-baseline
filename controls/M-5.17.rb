control "M-5.17" do
  title "5.17 Ensure host devices are not directly exposed to containers
(Not\nScored)"
  desc  "
    Host devices can be directly exposed to containers at runtime. Do not
directly expose host
    devices to containers especially for containers that are not trusted.
    The --device option exposes the host devices to the containers and
consequently, the
    containers can directly access such host devices. You would not require the
container to
    run in privileged mode to access and manipulate the host devices. By
default, the
    container will be able to read, write and mknod these devices.
Additionally, it is possible for
    containers to remove block devices from the host. Hence, do not expose host
devices to
    containers directly.
    If at all, you would want to expose the host device to a container, use the
sharing
    permissions appropriately:



    r - read only
    w - writable
    m - mknod allowed

  "
  impact 0.5
  tag "ref": "1.
https://docs.docker.com/engine/reference/commandline/run/#options\n"
  tag "severity": "medium"
  tag "cis_id": "5.17"
  tag "cis_control": ["14", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["AC-6", "4"]
  tag "check_text": "docker ps --quiet --all | xargs docker inspect --format '{{ .Id
}}:\nDevices={{ .HostConfig.Devices }}'\nThe above command would list out each
device with below information:\n\n\n\nCgroupPermissions - For example,
rwm\nPathInContainer - Device path within the container\nPathOnHost - Device
path on the host\nVerify that the host device is needed to be accessed from
within the container and the\npermissions required are correctly set. If the
above command returns [], then the container\ndoes not have access to host
devices. This recommendation can be assumed to be\ncompliant.\n"
  tag "fix": "Do not directly expose the host devices to containers. If at all,
you need to expose the host\ndevices to containers, use the correct set of
permissions:\nFor example, do not start a container as below:\ndocker run
--interactive --tty --device=/dev/tty0:/dev/tty0:rwm
-device=/dev/temp_sda:/dev/temp_sda:rwm centos bash\nFor example, share the
host device with correct permissions:\ndocker run --interactive --tty
--device=/dev/tty0:/dev/tty0:rw -device=/dev/temp_sda:/dev/temp_sda:r centos
bash\n"
  tag "Default Value": "By default, no host devices are exposed to containers.
If you do not provide sharing\npermissions and choose to expose a host device
to a container, the host device would be\nexposed with read, write and mknod
permissions.\n"
  ref url: 'https://docs.docker.com/engine/reference/commandline/cli/#run'

  docker.containers.running?.ids.each do |id|
    describe docker.object(id) do
      its(%w(HostConfig Devices)) { should be_empty }
    end
  end
end
