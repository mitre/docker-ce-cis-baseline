control 'M-6.3' do
  impact 0.0
  title 'Backup container data'
  desc 'Take regular backups of your container data volumes.'

  tag cis: '6.3'
  tag level: 1
  ref url: 'https://docs.docker.com/engine/userguide/containers/dockervolumes/'
  ref url: 'http://stackoverflow.com/questions/26331651/how-can-i-backup-a-docker-container-with-its-data-volumes'
  ref url: 'https://docs.docker.com/engine/reference/commandline/cli/#diff'
end
