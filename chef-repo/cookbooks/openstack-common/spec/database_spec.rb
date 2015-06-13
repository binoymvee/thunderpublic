# encoding: UTF-8
require_relative 'spec_helper'
require ::File.join ::File.dirname(__FILE__), '..', 'libraries', 'database'

describe 'openstack-common::default' do
  describe 'Openstack Database' do
    let(:runner) { ChefSpec::Runner.new(CHEFSPEC_OPTS) }
    let(:node) { runner.node }
    let(:chef_run) { runner.converge(described_recipe) }
    let(:subject) { Object.new.extend(Openstack) }

    include_context 'library-stubs'

    describe '#db_create_with_user' do
      before do
        allow(subject).to receive(:include_recipe)
          .with('database::mysql')
          .and_return('')
      end

      it 'returns nil when no such service was found' do
        expect(
          subject.db_create_with_user('nonexisting', 'user', 'pass')
        ).to be_nil
      end

      it 'returns db info and creates database with user when service found' do
        ['mysql', 'pgsql', 'postgresql'].each do |db_type|
          encoding = node['openstack']['db']['charset'][db_type]
          if encoding.nil?
            allow(subject).to receive(:database).and_return({})
          else
            allow(subject).to receive(:database).with(encoding: encoding).and_return({})
          end
        end
        allow(subject).to receive(:database_user).and_return({})
        result = subject.db_create_with_user('compute', 'user', 'pass')
        expect(result['host']).to eq('127.0.0.1')
        expect(result['port']).to eq('3306')
      end

      it 'creates database' do
        skip 'TODO: test this LWRP'
      end

      it 'creates database user' do
        skip 'TODO: test this LWRP'
      end

      it 'grants privs to database user' do
        skip 'TODO: test this LWRP'
      end
    end
  end
end
