module Scm::Adapters
	class BzrAdapter < AbstractAdapter
		def english_name
			"Bazaar"
		end
	end
end

require 'lib/scm/adapters/bzr/validation'
require 'lib/scm/adapters/bzr/commits'
require 'lib/scm/adapters/bzr/head'
