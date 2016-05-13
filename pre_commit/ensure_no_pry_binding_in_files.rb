module Overcommit::Hook::PreCommit
  class EnsureNoPryBindingInFiles < Base
    def run
      errors = []

      applicable_files.reject { |file| File.basename(file) =~ /^ensure_no_pry_binding_in_files\.rb$/ }.each do |file|
        if File.read(file) =~ /pry\.binding/
          errors << "#{file}: contains 'pry.binding'`"
        end
      end

      return :fail, errors.join("\n") if errors.any?

      :pass
    end
  end
end

