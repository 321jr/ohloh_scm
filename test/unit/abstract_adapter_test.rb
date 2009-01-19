require File.dirname(__FILE__) + '/../test_helper'

module Scm::Adapters
	class AbstractAdapterTest < Scm::Test
		def test_simple_validation
			scm = AbstractAdapter.new()
			assert !scm.valid?
			assert_equal [[:url, "The URL can't be blank."]], scm.errors

			scm.url = "http://www.test.org/test"
			assert scm.valid?
			assert scm.errors.empty?
		end

		def test_valid_urls
			['http://www.ohloh.net'].each do |url|
				assert !AbstractAdapter.new(:url => url).validate_url
			end
		end

		def test_invalid_urls
			[nil, '', '*' * 121].each do |url|
				assert AbstractAdapter.new(:url => url).validate_url.any?
			end
		end

		def test_invalid_usernames
			['no spaces allowed', '/', ':', 'a'*33].each do |username|
				assert AbstractAdapter.new(:username => username).validate_username.any?
			end
		end

		def test_valid_usernames
			[nil,'','joe_36','a'*32].each do |username|
				assert !AbstractAdapter.new(:username => username).validate_username
			end
		end

		def test_invalid_passwords
			['no spaces allowed', 'a'*33].each do |password|
				assert AbstractAdapter.new(:password => password).validate_password.any?
			end
		end

		def test_valid_passwords
			[nil,'','abc','a'*32].each do |password|
				assert !AbstractAdapter.new(:password => password).validate_password
			end
		end

		def test_invalid_branch_names
			['%','a'*51].each do |branch_name|
				assert AbstractAdapter.new(:branch_name => branch_name).validate_branch_name.any?
			end
		end

		def test_valid_branch_names
			[nil,'','/trunk','_','a'*50].each do |branch_name|
				assert !AbstractAdapter.new(:branch_name => branch_name).validate_branch_name
			end
		end

		def test_normalize
			scm = AbstractAdapter.new(:url => "   http://www.test.org/test   ", :username => "  joe  ", :password => "  abc  ", :branch_name => "   trunk  ")
			scm.normalize
			assert_equal "http://www.test.org/test", scm.url
			assert_equal "trunk", scm.branch_name
			assert_equal "joe", scm.username
			assert_equal "abc", scm.password
		end
	end
end
