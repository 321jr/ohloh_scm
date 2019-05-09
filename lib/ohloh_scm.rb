# frozen_string_literal: true

module OhlohScm
end

require 'time'
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

require_relative 'ohloh_scm/parser/hg_parser'
require_relative 'ohloh_scm/hg_scm'
require_relative 'ohloh_scm/hg_activity'
require_relative 'ohloh_scm/hg_status'
require_relative 'ohloh_scm/hg_lib_scm'
require_relative 'ohloh_scm/hg_lib_activity'
require_relative 'ohloh_scm/hg_lib_status'

require_relative 'ohloh_scm/bzr_scm'
require_relative 'ohloh_scm/bzr_activity'
require_relative 'ohloh_scm/bzr_status'
require_relative 'ohloh_scm/parser/bzr_xml_parser'

require_relative 'ohloh_scm/cvs_scm'
require_relative 'ohloh_scm/cvs_activity'
require_relative 'ohloh_scm/cvs_status'

require_relative 'ohloh_scm/factory'
