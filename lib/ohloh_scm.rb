# frozen_string_literal: true

module OhlohScm
end

require 'tmpdir'
require 'forwardable'

require_relative 'ohloh_scm/string_extensions'
require_relative 'ohloh_scm/version'
require_relative 'ohloh_scm/system'
require_relative 'ohloh_scm/diff'
require_relative 'ohloh_scm/commit'
require_relative 'ohloh_scm/parser'
require_relative 'ohloh_scm/base'
require_relative 'ohloh_scm/scm'
require_relative 'ohloh_scm/activity'
require_relative 'ohloh_scm/status'

require_relative 'ohloh_scm/git_scm'
require_relative 'ohloh_scm/git_activity'
require_relative 'ohloh_scm/git_status'

require_relative 'ohloh_scm/git_svn_scm'
require_relative 'ohloh_scm/git_svn_activity'
require_relative 'ohloh_scm/git_svn_status'

require_relative 'ohloh_scm/factory'
