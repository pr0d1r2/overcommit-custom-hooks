# frozen_string_literal: true

require 'active_support/core_ext/module/delegation'
require 'yaml'

# Our hook manager.
module Overcommit
  # Its hooks.
  module Hook
    # Particular phase.
    module PreCommit
      # Check if bundle does not exceed object allocation and retention limits.
      class DerailedBundleObjects < Base
        # Error aggregation.
        class Errors
          # Config for all environments.
          CONFIG = YAML.load_file('config/derailed/bundle_objects.yml').freeze
          # Parameters mapping.
          MAPPING = %w[allocated_bytes allocated_objects retained_bytes retained_objects].freeze

          # Process specific environment.
          class Environment
            attr_reader :config, :environment

            def initialize(environment, config)
              @config = config
              @environment = environment
            end

            # Process a single environment.
            def process
              config.map { |name, expected| process_variable(environment, name, expected) }
            end

            private

            # Four values from shell command.
            def values
              @values ||= `bin/derailed_bundle_objects #{environment}`.split("\n").map(&:to_i)
            end

            # Process specific variable.
            def process_variable(environment, name, expected)
              errors = []
              actual = values[MAPPING.find_index(name)]
              errors = ["#{actual} > #{expected}"] if actual > expected

              [environment, name, errors].flatten.join("\n") if errors.any?
            end
          end

          delegate :any?, :join, to: :errors

          private

          # Aggregated errors from all environments.
          def errors
            @errors = CONFIG.flat_map { |environment, config| Environment.new(environment, config).process }
          end

          private_constant :CONFIG
          private_constant :MAPPING
        end

        # Run command with limit.
        def run
          return :fail, errors.join("\n") if errors.any?

          :pass
        end

        # Error aggregation instance.
        def errors
          @errors ||= Errors.new
        end
      end
    end
  end
end
