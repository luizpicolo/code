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

require 'spec_helper'

feature 'Sign out', js: false do
  let!(:user) { FactoryGirl.create(:user) }

  scenario 'always works' do
    sign_in user
    sign_out
    expect(page).to have_content('Para continuar, efetue login ou registre-se.')
  end
end
