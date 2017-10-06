control 'M-6.2' do
  impact 0.0
  title 'Monitor Docker containers usage, performance and metering'
  desc 'Containers might run services that are critical for your business. Monitoring their usage, performance and metering would be of paramount importance.'

  tag cis: '6.2'
  tag level: 1
  ref url: 'https://docs.docker.com/v1.8/articles/runmetrics/'
  ref url: 'https://github.com/google/cadvisor'
  ref url: 'https://docs.docker.com/engine/reference/commandline/cli/#stats'
end
