require File.dirname(__FILE__) + '/../test_helper'

module Scm::Adapters
	class GitPushTest < Scm::Test

		def test_hostname
			assert_equal "foo", GitAdapter.new(:url => 'foo:/bar').hostname
			assert_equal "/bar", GitAdapter.new(:url => 'foo:/bar').path

			assert !GitAdapter.new.hostname
			assert !GitAdapter.new(:url => '/bar').hostname
			assert_equal 'http', GitAdapter.new(:url => 'http://www.ohloh.net/bar').hostname
		end

		def test_local
			assert !GitAdapter.new(:url => "foo:/bar").local? # Assuming your machine is not named "foo" :-)
			assert !GitAdapter.new(:url => "http://www.ohloh.net/foo").local?
			assert GitAdapter.new(:url => "src").local?
			assert GitAdapter.new(:url => "/Users/robin/src").local?
			assert GitAdapter.new(:url => "#{`hostname`.strip}:src").local?
			assert GitAdapter.new(:url => "#{`hostname`.strip}:/Users/robin/src").local?
		end

		def test_basic_push
			with_git_repository('git') do |src|
				Scm::ScratchDir.new do |dest_dir|

					dest = GitAdapter.new(:url => dest_dir).normalize
					assert !dest.exist?

					src.push(dest)
					assert dest.exist?
					assert_equal src.log, dest.log

					# Now push again. This tests a different code path!
					File.open(File.join(src.url, 'foo'), 'w') { }
					src.commit_all(Scm::Commit.new)

					src.push(dest)
					assert dest.exist?
					assert_equal src.log, dest.log

				end
			end
		end
	end
end
