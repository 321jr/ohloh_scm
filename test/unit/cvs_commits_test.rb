require File.dirname(__FILE__) + '/../test_helper'

module Scm::Adapters
	class CvsCommitsTest < Scm::Test

		def test_commits
			with_cvs_repository('cvs') do |cvs|

				assert_equal ['2006/06/29 16:19:58',
											'2006/06/29 16:21:07',
											'2006/06/29 18:14:47',
											'2006/06/29 18:45:29',
											'2006/06/29 18:48:54',
											'2006/06/29 18:52:23'], cvs.commits.collect { |c| c.token }

				assert_equal ['2006/06/29 18:48:54',
											'2006/06/29 18:52:23'], cvs.commits('2006/06/29 18:45:29').collect { |c| c.token }

				# Make sure we are date format agnostic (2008/01/01 is the same as 2008-01-01)
				assert_equal ['2006/06/29 18:48:54',
											'2006/06/29 18:52:23'], cvs.commits('2006-06-29 18:45:29').collect { |c| c.token }

				assert_equal [], cvs.commits('2006/06/29 18:52:23').collect { |c| c.token }
			end
		end
	end
end
