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

class SchoolPerformacesController < ApplicationController
  autocomplete :student, :name, display_value: :show_name

  before_action :set_school_performace, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @school_performaces = SearchWithUserService.new(SchoolPerformace, current_user).search(params)
    respond_with(@school_performaces)
  end

  def show
    respond_with(@school_performace)
  end

  def new
    @school_performace = SchoolPerformace.new
    respond_with(@school_performace)
  end

  def edit
  end

  def create
    @school_performace = SchoolPerformace.new(school_performace_params)
    @school_performace.user = current_user
    if @school_performace.save
      redirect_to school_performaces_path, flash: { success: 'Desempenho escolar cadastro com sucesso' }
    else
      flash.now[:error] = @school_performace.errors.full_messages
      render :new
    end
  end

  def update
    if @school_performace.update(school_performace_params)
      redirect_to school_performaces_path, flash: { success: 'Desempenho escolar atualizado com sucesso' }
    else
      flash.now[:error] = @school_performace.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @school_performace.destroy
      redirect_to school_performaces_path, flash: { success: 'Desempenho escolar excluído com sucesso' }
    else
      redirect_to school_performaces_path, flash: { error: 'Erro ao excluir Desempenho escolar ' }
    end
  end

  private
  def set_school_performace
    @school_performace = SchoolPerformace.find(params[:id])
  end

  def school_performace_params
    params.require(:school_performace).permit(:student_id, :user_id, :start_date, :finish_date, :description)
  end
end
