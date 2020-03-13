require_relative "../lib/payday"

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories.
Dir["spec/support/**/*.rb"].each { |f| require f[5..-1] }

Money.locale_backend = :currency
Money.rounding_mode  = BigDecimal::ROUND_HALF_UP

RSpec.configure do |_config|
  # some (optional) config here
end
