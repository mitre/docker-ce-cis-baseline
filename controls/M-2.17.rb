control "M-2.17" do
  title "2.17 Ensure experimental features are avoided in production (Scored)"
  desc  "
    Avoid experimental features in production.
    Experimental is now a runtime docker daemon flag instead of a separate
build. Passing -experimental as a runtime flag to the docker daemon, activates
experimental features.
    Experimental is now considered a stable release, but with a couple of
features which might
    not have tested and guaranteed API stability.

  "
  impact 0.5
  tag "ref": "1.
https://docs.docker.com/edge/engine/reference/commandline/dockerd/#options\n"
  tag "severity": "medium"
  tag "cis_id": "2.17"
  tag "cis_control": ["18", "6.1"]
  tag "cis_level": "Level 1 - Docker"
  tag "nist": ["SI-1", "4"]
  tag "check_text": "Run the below command and ensure that the Experimental property
is set to false in the\nServer section.\ndocker version --format '{{
.Server.Experimental }}'\n"
  tag "fix": "Do not pass --experimental as a runtime parameter to the docker
daemon.\n"
  tag "Default Value": "By default, experimental features are not activated on
the docker daemon.\n"
end
