module Hijack
  module Helper
    class << self
      def helpers
        methods.find_all {|meth| meth =~ /^hijack_/}.map { |meth| meth.to_s }
      end

      def find_helper(statements)
        helpers.include?(statements.strip) ? statements.strip : nil
      end

      def helpers_like(str)
        found = helpers.find_all { |helper| helper =~ Regexp.new(str) }
        found.empty? ? nil : found
      end

      def hijack_mute(remote)
        Hijack::OutputReceiver.mute
        true
      end

      def hijack_unmute(remote)
        Hijack::OutputReceiver.unmute
        true
      end

      def hijack_debug_mode(remote)
        hijack_mute(remote)
        require 'rubygems'
        require 'ruby-debug'
        remote.evaluate(<<-RUBY)
          require 'rubygems'
          require 'ruby-debug'
          Debugger.start_remote
        RUBY
        true
      end

      def hijack_debug_start(remote)
        Debugger.start_client
        true
      end
    end
  end
end
