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

# Module
module SchoolPerformaceHelpers
  # Create new student
  def create_school_performace
    click_link('Desempenho escolar')
    click_link('Novo desempenho escolar')

    student = FactoryGirl.create(:student)

    fill_in 'school_performace_student_id', with: student.id.to_s + ' - ' + student.name
    fill_in 'Início', with: Time.zone.now - 1.month
    fill_in 'Final', with: Time.zone.now
    fill_in 'Descrição', with: Faker::Lorem.paragraph

    click_button('Criar Desempenho escolar')

    search_school_performace_by_name_student(student.name)
  end

  def update_school_performace
    click_link('Desempenho escolar')
    first(:link, 'Editar').click

    student = FactoryGirl.create(:student)

    # fill_in 'school_performace_student_id', with: student.id.to_s + ' - ' + student.name
    fill_in 'Início', with: Time.zone.now - 1.month
    fill_in 'Final', with: Time.zone.now
    fill_in 'Descrição', with: Faker::Lorem.paragraph

    click_button('Atualizar Desempenho escolar')

    search_school_performace_by_name_student(student.name)
  end

  # delete
  def delete_school_performace(school_performace)
    page.driver.submit :delete, "/school_performaces/#{search_school_performace(school_performace).id.to_s}", {}
  end

  def search_school_performace_by_name_student(name)
    student = Student.find_by_name(name)
    SchoolPerformace.find_by_student_id(student.id)
  end

  def search_school_performace(school_performace)
    SchoolPerformace.find(school_performace.id)
  end
end

RSpec.configure do |config|
  config.include SchoolPerformaceHelpers, type: :feature
end
