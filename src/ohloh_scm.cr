module OhlohScm
end

require "./ohloh_scm/shellout"
require "./ohloh_scm/scratch_dir"
require "./ohloh_scm/commit"
require "./ohloh_scm/diff"

require "./ohloh_scm/adapters/abstract_adapter"
require "./ohloh_scm/adapters/cvs_adapter"
require "./ohloh_scm/adapters/svn_adapter"
require "./ohloh_scm/adapters/svn_chain_adapter"
require "./ohloh_scm/adapters/git_adapter"
require "./ohloh_scm/adapters/hg_adapter"
require "./ohloh_scm/adapters/hglib_adapter"
require "./ohloh_scm/adapters/bzr_adapter"
require "./ohloh_scm/adapters/bzrlib_adapter"
require "./ohloh_scm/adapters/factory"

require "./ohloh_scm/parsers/parser"
require "./ohloh_scm/parsers/branch_number"
require "./ohloh_scm/parsers/cvs_parser"
require "./ohloh_scm/parsers/svn_parser"
require "./ohloh_scm/parsers/svn_xml_parser"
require "./ohloh_scm/parsers/git_parser"
require "./ohloh_scm/parsers/git_styled_parser"
require "./ohloh_scm/parsers/hg_parser"
require "./ohloh_scm/parsers/hg_styled_parser"
require "./ohloh_scm/parsers/bzr_xml_parser"
require "./ohloh_scm/parsers/bzr_parser"

require "./ohloh_scm/parsers/array_writer"
require "./ohloh_scm/parsers/xml_writer"
require "./ohloh_scm/parsers/human_writer"
