module Overcommit::Hook::PreCommit
  class EnsureNoByebugInFiles < Base
    def run
      errors = []

      applicable_files.reject { |file| File.basename(file) =~ /^Gemfile|ensure_no_byebug_in_files\.rb/ }.each do |file|
        errors << "#{file}: contains 'byebug'`" if File.read(file) =~ /byebug/
      end

      return :fail, errors.join("\n") if errors.any?

      :pass
    end
  end
end
