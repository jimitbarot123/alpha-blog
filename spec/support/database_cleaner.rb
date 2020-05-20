RSpec.configure do |config|

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction # Default strategy
    DatabaseCleaner.clean_with :truncation, except: %w(ar_internal_metadata) # Initially clean with truncation
  end

  config.before(:each, type: :request) do
    # Swap to truncation as Selenium runs in separate thread with a different
    # database connection
    DatabaseCleaner.strategy = :truncation
  end

  config.after(:each, type: :request) do
    # Reset so non-request specs can use transaction
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
