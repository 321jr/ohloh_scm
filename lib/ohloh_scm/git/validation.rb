# frozen_string_literal: true

module OhlohScm
  module Git
    class Validation < OhlohScm::Validation
      def validate
        super
        @errors << [:branch_name, 'Invalid Branch Name.'] if scm.branch_name.to_s.empty?
      end

      private

      def validate_server_connection
        msg = "The server did not respond to the 'git-ls-remote' command."
        msg << ' Are the URL and Branch fields correct?'
        @errors << [:failed, msg] unless status.exist?
      end

      def public_url_regex
        %r{^(http|https|git)://(\w+@)?[\w\-\.]+(:\d+)?/[\w\-\./\~\+]*$}
      end
    end
  end
end
