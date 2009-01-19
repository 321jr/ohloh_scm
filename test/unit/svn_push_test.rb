require File.dirname(__FILE__) + '/../test_helper'
require 'socket'

module Scm::Adapters
	class SvnPushTest < Scm::Test

		def test_basic_push_using_svnsync
			with_svn_repository('svn') do |src|
				Scm::ScratchDir.new do |dest_dir|

					dest = SvnAdapter.new(:url => dest_dir).normalize
					assert !dest.exist?

					src.push(dest)
					assert dest.exist?

					assert_equal src.log, dest.log
				end
			end
		end

		# Triggers the "ssh" code path by using svn+ssh:// protocol instead of file:// protocol.
		# Simulates pushing to another server in our cluster.
		def test_ssh_push_using_svnsync
			with_svn_repository('svn') do |src|
				Scm::ScratchDir.new do |dest_dir|

					dest = SvnAdapter.new(:url => "svn+ssh://#{Socket.gethostname}#{File.expand_path(dest_dir)}").normalize
					assert !dest.exist?

					src.push(dest)
					assert dest.exist?

					assert_equal src.log, dest.log
				end
			end
		end

	end
end
