require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'pgpool::hba', :type => :define do

  let(:title) { 'pgpool::hba' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :arch => 'i386', :operatingsystem => 'CentOS', :concat_basedir => '/var/lib/puppet/concat' } }
  let(:params) { {
    :type     => 'local',
    :database => 'all',
    :user     => 'all',
    :method   => 'password'
  } }

  describe 'Test pgpool::hba require pgpool to be install' do
    it { should contain_concat('/etc/pgpool-II-92/pool_hba.conf').with_require(/Package/) }
  end
end
