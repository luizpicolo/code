# Module
module StudentHelpers
  # Create new student
  def create_student
    click_link('Estudantes')
    click_link('Novo estudante')

    name = Faker::Name.name

    fill_in 'Nome', with: name
    fill_in 'Responsável', with: Faker::Name.name
    fill_in 'Contato resp.', with: Faker::Internet.email
    fill_in 'Data matrícula', with: Time.zone.now - 2.month
    check('Ativo?')

    click_button('Criar Estudante')

    search_student_by_name(name)
  end

  # Create new student
  def update_student
    click_link('Estudantes')
    first(:link, 'Editar').click

    name = Faker::Name.name

    fill_in 'Nome', with: name
    fill_in 'Responsável', with: Faker::Name.name
    fill_in 'Contato resp.', with: Faker::Internet.email
    fill_in 'Data matrícula', with: Time.zone.now - 1.month
    check('Ativo?')

    click_button('Atualizar Estudante')

    search_student_by_name(name)
  end

  # delete
  def delete_student(student)
    page.driver.submit :delete, "/students/#{search_student_by_name(student.name).id.to_s}", {}
  end

  def search_student_by_name(name)
    Student.find_by_name(name)
  end
end

RSpec.configure do |config|
  config.include StudentHelpers, type: :feature
end
