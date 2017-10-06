control 'M-1.2_old' do
  impact 0.0
  title 'Use the updated Linux Kernel'
  desc 'Docker in daemon mode has specific kernel requirements. A 3.10 Linux kernel is the minimum requirement for Docker.'

  tag cis_control: '1.2'
  tag level: 1
  ref 'Check kernel dependencies', url: 'https://docs.docker.com/engine/installation/binaries/#check-kernel-dependencies'
  ref 'Installation list', url: 'https://docs.docker.com/engine/installation/#installation-list'

  only_if { os.linux? }
  kernel_version = command('uname -r | grep -o \'^\w\.\w*\.\w*\'').stdout
  kernel_compare = Gem::Version.new('3.10') <= Gem::Version.new(kernel_version)
  describe kernel_compare do
    it { should eq true }
  end
end
