class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if params[:search].nil?
      @students = Student.all.page(params[:page])
    else
      @students = Student.search(params[:search]).page(params[:page])
    end
    respond_with(@students)
  end

  def show
    respond_with(@student)
  end

  def new
    @student = Student.new
    respond_with(@student)
  end

  def edit
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to students_path, flash: { success: 'Estudante cadastro com sucesso' }
    else
      error_msg = ''
      @student.errors.full_messages.each do |msg|
        error_msg << "<div>#{msg}</div>"
      end
      redirect_to new_student_path, flash: { error: error_msg }
    end
  end

  def update
    if @student.update(student_params)
      redirect_to students_path, flash: { success: 'Estudante atualizado com sucesso' }
    else
      error_msg = ''
      @student.errors.full_messages.each do |msg|
        error_msg << "<div>#{msg}</div>"
      end
      redirect_to new_student_path, flash: { error: error_msg }
    end
  end

  def destroy
    if @student.destroy
      redirect_to students_path, flash: { success: 'Estudante excluído com sucesso' }
    else
      redirect_to students_path, flash: { error: 'Erro ao excluir estudante' }
    end
  end

  private
    def set_student
      @student = Student.find(params[:id])
    end

    def student_params
      params.require(:student).permit(:name, :responsible, :contact_responsible, :date_enrolment, :image, :status)
    end
end
