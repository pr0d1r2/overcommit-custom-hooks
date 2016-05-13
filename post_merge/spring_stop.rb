require_relative '../shared/spring_stop'

module Overcommit::Hook::PostMerge
  # Runs `spring stop` when a change is detected in the repository's
  # dependencies.
  #
  # @see {Overcommit::Hook::Shared::SpringStop}
  class SpringStop < Base
    include Overcommit::Hook::Shared::SpringStop
  end
end
