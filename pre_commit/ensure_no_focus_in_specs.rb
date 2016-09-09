module Overcommit::Hook::PreCommit
  class EnsureNoFocusInSpecs < Base
    FOCUS_STRINGS = [
      ', :focus ',
      ', focus: true ',
      ', :focus => true ',
      ', "focus" => true ',
      ", 'focus' => true ",
    ].freeze

    def run
      errors = []
      applicable_files.each do |file|
        if File.read(file) =~ /(#{FOCUS_STRINGS.join('|')})/
          errors << "#{file}: contains '#{focus_string}'`"
        end
      end

      return :fail, errors.join("\n") if errors.any?

      :pass
    end
  end
end
