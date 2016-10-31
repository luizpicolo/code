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
      flash.now[:error] = @student.errors.full_messages
      render :new
    end
  end

  def update
    if @student.update(student_params)
      redirect_to students_path, flash: { success: 'Estudante atualizado com sucesso' }
    else
      flash.now[:error] = @student.errors.full_messages
      render :edit
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
