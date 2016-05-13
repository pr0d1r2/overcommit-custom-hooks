module Overcommit::Hook::Shared
  # Shared code used by all SpringStop hooks. Runs `spring stop` when a change
  # is detected in the repository's dependencies.
  #
  # @see https://www.npmjs.com/
  module SpringStop
    def run
      result = execute(command)
      return :fail, result.stderr unless result.success?
      :pass
    end

    private

    def command
      %w[spring stop]
    end
  end
end
