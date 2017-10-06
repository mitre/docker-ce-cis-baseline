control "M-5.14" do
  title "5.14 Ensure 'on-failure' container restart policy is set to '5'
(Scored)"
  desc  "
    Using the --restart flag in docker run command you can specify a restart
policy for how a
    container should or should not be restarted on exit. You should choose the
on-failure
    restart policy and limit the restart attempts to 5.
    If you indefinitely keep trying to start the container, it could possibly
lead to a denial of
    service on the host. It could be an easy way to do a distributed denial of
service attack
    especially if you have many containers on the same host. Additionally,
ignoring the exit
    status of the container and always attempting to restart the container
leads to noninvestigation of the root cause behind containers getting
terminated. If a container gets
    terminated, you should investigate on the reason behind it instead of just
attempting to
    restart it indefinitely. Thus, it is recommended to use on-failure restart
policy and limit it
    to maximum of 5 restart attempts.

  "
  impact 0.5
  tag "ref": "1.
https://docs.docker.com/engine/reference/commandline/run/#restart-policiesrestart\n"
  tag "severity": "medium"
  tag "cis_id": "5.14"
  tag "cis_control": ["18", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["SI-1", "4"]
  tag "check_text": "docker ps --quiet --all | xargs docker inspect --format '{{ .Id
}}:\nRestartPolicyName={{ .HostConfig.RestartPolicy.Name }}
MaximumRetryCount={{\n.HostConfig.RestartPolicy.MaximumRetryCount }}'\n\n\n\nIf
the above command returns RestartPolicyName=always, then the system is
not\nconfigured as desired and hence this recommendation is non-compliant.\nIf
the above command returns RestartPolicyName=no or just
RestartPolicyName=,\nthen the restart policies are not being used and the
container would never be\nrestarted of its own. This recommendation is then Not
Applicable and can be\nassumed to be compliant.\nIf the above command returns
RestartPolicyName=on-failure, then verify that the\nnumber of restart attempts
is set to 5 or less by looking at MaximumRetryCount.\n"
  tag "fix": "If a container is desired to be restarted of its own, then, for
example, you could start the\ncontainer as below:\ndocker run --detach
--restart=on-failure:5 nginx\n"
  tag "Default Value": "By default, containers are not configured with restart
policies. Hence, containers do not\nattempt to restart of their own.\n"
  ref url: 'https://docs.docker.com/engine/reference/commandline/cli/#restart-policies'

  docker.containers.running?.ids.each do |id|
    describe.one do
      describe docker.object(id) do
        its(%w(HostConfig RestartPolicy Name)) { should eq 'no' }
      end
      describe docker.object(id) do
        its(%w(HostConfig RestartPolicy Name)) { should eq 'on-failure' }
        its(%w(HostConfig RestartPolicy MaximumRetryCount)) { should eq 5 }
      end
    end
  end
end
