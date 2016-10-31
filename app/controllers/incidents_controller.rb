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

# Class
class IncidentsController < ApplicationController
  autocomplete :student, :name, display_value: :show_name

  before_action :set_incident, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @incidents = SearchWithUserService.new(Incident, current_user).search(params)
    respond_with(@incidents)
  end

  def show
    respond_with(@incident)
  end

  def new
    @incident = Incident.new
    respond_with(@incident)
  end

  def edit
  end

  def create
    @incident = Incident.new(incident_params)
    @incident.user = current_user

    if @incident.save
      redirect_to incident_path(@incident), flash: { success: 'Ocorrência cadastrada com sucesso' }
    else
      flash.now[:error] = @incident.errors.full_messages
      render :new
    end
  end

  def update
    @incident.update(incident_params)
    if @incident.update(incident_params)
      redirect_to incident_path(@incident), flash: { success: 'Ocorrência atualizada com sucesso' }
    else
      flash.now[:error] = @incident.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @incident.destroy
      redirect_to incidents_path, flash: { success: 'Ocorrência excluída com sucesso' }
    else
      redirect_to incidents_path, flash: { error: 'Erro ao excluir ocorrência' }
    end
  end

  private

  def set_incident
    @incident = Incident.find(params[:id])
  end

  def incident_params
    params.require(:incident).permit(
      :student_id, :user_id, :date_incident, :description, :soluction
    )
  end
end
