require "graphql_matchers"

module GraphqlExampleGroup
  extend ActiveSupport::Concern
  include GraphqlMatchers

  included do
    def operation(operation_name)
      response&.dig("data", operation_name.to_s).tap do |operation|
        raise "Response for Graphql operation not found: #{operation_name}" if operation.nil?
      end
    end

    subject {
      RudySchema.execute graphql_query,
                         context: graphql_context,
                         variables: graphql_variables
    }

    let(:graphql_context) { {} }

    let(:graphql_query) { raise 'You must add a "let(:graphql_query) { ... }" to your specs' }

    let(:graphql_variables) { {} }

    let(:response) { subject.to_h.with_indifferent_access }
  end

  RSpec.configure do |config|
    config.include(self, type: :graphql)

    RSpec::Rails::DIRECTORY_MAPPINGS[:graphql] = %w[spec graphql]
  end
end
