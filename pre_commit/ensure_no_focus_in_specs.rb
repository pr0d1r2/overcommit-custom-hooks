module Overcommit::Hook::PreCommit
  class EnsureNoFocusInSpecs < Base
    def run
      errors = []

      applicable_files.each do |file|
        if File.read(file) =~ /, :focus /
          errors << "#{file}: contains ', :focus '`"
        end
      end

      return :fail, errors.join("\n") if errors.any?

      :pass
    end
  end
end
