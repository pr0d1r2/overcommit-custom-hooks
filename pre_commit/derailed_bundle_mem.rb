# frozen_string_literal: true

require 'yaml'

# Our hook manager.
module Overcommit
  # Its hooks.
  module Hook
    # Particular phase.
    module PreCommit
      # Check if bundle does not exceed limit in MiB.
      class DerailedBundleMem < Base
        # Config for all environments.
        CONFIG = YAML.load_file('config/derailed/bundle_mem.yml').freeze

        # Run command with limit.
        def run
          CONFIG.each do |environment, cut_off|
            errors = `CUT_OFF=#{cut_off} bundle exec derailed bundle:mem #{environment}`.split("\n")

            return :fail, [environment, errors].flatten.join("\n") if errors.any?
          end

          :pass
        end

        private_constant :CONFIG
      end
    end
  end
end
