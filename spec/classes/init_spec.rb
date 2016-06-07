require 'spec_helper'
describe 'dropbox' do

  context 'on unsupported distributions' do
    let(:facts) {{ :osfamily => 'Unsupported' }}

    it 'it fails' do
      expect { subject.call }.to raise_error(/is not supported on an Unsupported based system/)
    end
  end

  ['Debian'].each do |distro|
    context "on #{distro} with default settings" do
      let(:facts) {{
        :osfamily => distro,
        :lsbdistid => distro,
        :operatingsystem => distro,
        :lsbdistcodename => 'jessie',
      }}

      it { should contain_class('dropbox::install') }

      it 'includes dropbox::repo::apt' do
        should contain_class('dropbox::repo::apt')
      end

      it { should contain_apt__source('dropbox').with(
        'location'    => 'http://linux.dropbox.com/'+distro.downcase,
        'release'     => 'jessie',
        'repos'       => 'main',
        'include_src' => false,
        'key'         => '1C61A2656FB57B7E4DE0F4C1FC918B335044912E'
      )}

      describe 'package installation' do
        it { should contain_package('dropbox').with(
          'ensure' => 'installed',
          'name'   => 'dropbox',
        )}
      end
    end
  end

end
