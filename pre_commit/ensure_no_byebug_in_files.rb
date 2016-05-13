module Overcommit::Hook::PreCommit
  class EnsureNoByebugInFiles < Base
    def run
      errors = []

      applicable_files.reject { |file| File.basename(file) =~ /$Gemfile/ }.each do |file|
        if File.read(file) =~ /byebug/
          errors << "#{file}: contains 'byebug'`"
        end
      end

      return :fail, errors.join("\n") if errors.any?

      :pass
    end
  end
end
