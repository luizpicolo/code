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
    @incident.save
    respond_with(@incident)
  end

  def update
    @incident.update(incident_params)
    respond_with(@incident)
  end

  def destroy
    @incident.destroy
    respond_with(@incident)
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
