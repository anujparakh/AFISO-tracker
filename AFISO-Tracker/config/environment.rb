# Load the Rails application.
require_relative "application"

ENV['LOCKUP_CODEWORD'] = 'secret'
ENV['COOKIE_LIFETIME_IN_WEEKS'] = '1'


# Initialize the Rails application.
Rails.application.initialize!
