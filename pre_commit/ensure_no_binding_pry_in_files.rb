module Overcommit::Hook::PreCommit
  class EnsureNoBindingPryInFiles < Base
    def run
      errors = []

      applicable_files.reject { |file| File.basename(file) =~ /^ensure_no_binding_pry_in_files\.rb$/ }.each do |file|
        if File.read(file) =~ /binding\.pry/
          errors << "#{file}: contains 'binding.pry'`"
        end
      end

      return :fail, errors.join("\n") if errors.any?

      :pass
    end
  end
end
