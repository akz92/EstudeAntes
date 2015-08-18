RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  # Testing every factory validity before running any test
  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end
end
