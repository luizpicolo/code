Rails.env.on(:any) do
  # Disabel Generate assets and helpes
  config.generators.assets = false
  config.generators.helper = false

  # don't generate RSpec tests for views and helpers
  config.generators do |g|
    g.test_framework :rspec, fixture: true
    g.fixture_replacement :factory_girl, dir: 'spec/factories'
    g.view_specs false
    g.helper_specs false
  end
end
