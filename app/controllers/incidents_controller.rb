# Class
class IncidentsController < ApplicationController
  autocomplete :student, :name, display_value: :show_name

  before_action :set_incident, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    if current_user.admin?
      @incidents = Incident.search(params[:search]).page(params[:page])
    else
      @incidents = Incident.where(user: current_user).search(params[:search]).page(params[:page])
    end
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
