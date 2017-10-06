LOG_DRIVER = attribute(
  'log_driver',
  description: 'define preferable way to store logs. cis-docker-benchmark-2.12',
  default: 'syslog'
)

LOG_OPTS = attribute(
  'log_opts',
  description: 'define Docker daemon log-opts. cis-docker-benchmark-2.12',
  default: /syslog-address/
)

control "M-2.12" do
  title "2.12 Ensure centralized and remote logging is configured (Scored)"
  desc  "
    Docker now supports various log drivers. A preferable way to store logs is
the one that
    supports centralized and remote logging.
    Centralized and remote logging ensures that all important log records are
safe despite
    catastrophic events. Docker now supports various such logging drivers. Use
the one that
    suits your environment the best.

  "
  impact 0.5
  tag "severity": "medium"
  tag "cis_id": "2.12"
  tag "cis_control": ["6.6", "6.1"]
  tag "cis_level": "Level 2 - Docker"
  tag "nist": ["SI-4(2)", "4"]
  tag "check_text": "Run docker info and ensure that the Logging Driverproperty set
as appropriate.\ndocker info --format '{{ .LoggingDriver }}'\nAlternatively,
the below command would give you the --log-driver setting, if
configured.\nEnsure that it is set as appropriate.\nps -ef | grep dockerd\n"
  tag "fix": "Step 1: Setup the desired log driver by following its
documentation.\nStep 2: Start the docker daemon with that logging driver.\nFor
example,\ndockerd --log-driver=syslog --log-opt
syslog-address=tcp://192.xxx.xxx.xxx\n"
  tag "Default Value": "By default, container logs are maintained as json
files\n"
  ref 'Logging overview', url: 'https://docs.docker.com/engine/admin/logging/overview/'

  describe json('/etc/docker/daemon.json') do
    its(['log-driver']) { should_not be_empty }
    its(['log-driver']) { should eq(LOG_DRIVER) }
    its(['log-opts']) { should include(LOG_OPTS) }
  end
end
