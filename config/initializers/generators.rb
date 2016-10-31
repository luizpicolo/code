################################################################################
# The MIT License (MIT)
#
# Copyright (c) 2016 C.O.D.E
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
################################################################################

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
