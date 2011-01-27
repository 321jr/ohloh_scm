require File.dirname(__FILE__) + '/../test_helper'

module Scm::Adapters
	class BzrCommitsTest < Scm::Test

		def test_commit_count
			with_bzr_repository('bzr') do |bzr|
				assert_equal 6, bzr.commit_count
				assert_equal 5, bzr.commit_count(:after => revision_ids.first)
				assert_equal 1, bzr.commit_count(:after => revision_ids[4])
				assert_equal 0, bzr.commit_count(:after => revision_ids.last)
			end
		end

		def test_commit_count_with_branches
			with_bzr_repository('bzr_with_branch') do |bzr|
				# Only 3 commits are on main line... make sure we catch the branch commit as well
				assert_equal 4, bzr.commit_count
			end
		end

		def test_commit_tokens
			with_bzr_repository('bzr') do |bzr|
				assert_equal revision_ids, bzr.commit_tokens
				assert_equal revision_ids[1..5], bzr.commit_tokens(:after => revision_ids.first)
				assert_equal revision_ids[5..5], bzr.commit_tokens(:after => revision_ids[4])
				assert_equal [], bzr.commit_tokens(:after => revision_ids.last)
			end
		end

		def test_commits
			with_bzr_repository('bzr') do |bzr|
				assert_equal revision_ids, bzr.commits.collect { |c| c.token }
				assert_equal revision_ids[5..5], bzr.commits(:after => revision_ids[4]).collect { |c| c.token }
				assert_equal [], bzr.commits(:after => revision_ids.last).collect { |c| c.token }

				# Check that the diffs are not populated
				assert_equal [], bzr.commits.first.diffs
			end
		end

		def test_each_commit
			with_bzr_repository('bzr') do |bzr|
				commits = []
				bzr.each_commit do |c|
					assert c.committer_name
					assert c.committer_date.is_a?(Time)
					assert c.message.length > 0
					assert c.diffs.any?
					# Check that the diffs are populated
					c.diffs.each do |d|
						assert d.action =~ /^[MAD]$/
						assert d.path.length > 0
					end
					commits << c
				end

				# Make sure we cleaned up after ourselves
				assert !FileTest.exist?(bzr.log_filename)

				# Verify that we got the commits in forward chronological order
				assert_equal revision_ids, commits.collect{ |c| c.token }
			end
		end

		# This bzr repository contains the following tree structure
		#    /foo/
		#    /foo/helloworld.c
		#    /bar/
		# Ohloh doesn't care about directories, so only /foo/helloworld.c should be reported.
		def test_each_commit_excludes_directories
			with_bzr_repository('bzr_with_subdirectories') do |bzr|
				commits = []
				bzr.each_commit do |c|
					commits << c
				end
				assert_equal 1, commits.size
				assert_equal 1, commits.first.diffs.size
				assert_equal 'foo/helloworld.c', commits.first.diffs.first.path
			end
		end

		# Verfies OTWO-344
		def test_commit_tokens_with_colon_character
			with_bzr_repository('bzr_colon') do |bzr|
				assert_equal ['svn-v4:364a429a-ab12-11de-804f-e3d9c25ff3d2::0'], bzr.commit_tokens
			end
		end

		protected

		def revision_ids
			[
				'obnox@samba.org-20090204002342-5r0q4gejk69rk6uv', # 1
				'obnox@samba.org-20090204002422-5ylnq8l4713eqfy0', # 2
				'obnox@samba.org-20090204002453-u70a3ehf3ae9kay1', # 3
				'obnox@samba.org-20090204002518-yb0x153oa6mhoodu', # 4
				'obnox@samba.org-20090204002540-gmana8tk5f9gboq9', # 5
				'obnox@samba.org-20090204004942-73rnw0izen42f154'  # 6
			]
		end

	end
end

