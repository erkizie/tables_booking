require "rspec/expectations"

module GraphqlMatchers
  extend RSpec::Matchers::DSL

  # expect(response).to have_errors
  # expect(response).to have_errors <matcher> # accepts arbitrary matcher to match against errors array
  # expect(response).to have_errors.with_messages(*matchers) # matches against the :message of each error
  # expect(response).to have_errors.with_messages("full message")
  # expect(response).to have_errors.with_messages(/message substring/)
  matcher :have_errors do |expected|
    match do |response|
      actual = response&.dig("errors")

      if expected.present?
        values_match? expected, actual
      elsif @error_messages.present?
        values_match? @error_messages, actual.pluck(:message)
      else
        actual.present?
      end
    end

    chain :with_messages do |*error_messages|
      @error_messages = error_messages
    end

    diffable
  end

  # expect(response).to have_data
  # expect(response).to have_data foo: "bar"
  # expect(response).to have_data include foo: "bar"
  # expect(response).to have_data include foo: hash_including(bar: "baz")
  matcher :have_data do |expected|
    match do |response|
      actual = response&.dig("data")

      if expected.present?
        values_match? expected, actual
      else
        actual.present?
      end
    end

    diffable
  end
end
