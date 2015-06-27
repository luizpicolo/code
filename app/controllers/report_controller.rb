class ReportController < ApplicationController
  autocomplete :student, :name, display_value: :show_name

  def index
  end

  def print
    id = params[:school_performace][:student_id].first(3)
    if params[:type] == '2'
      data_report = SchoolPerformace.report(id, params[:dinitial].to_date, params[:dfinish].to_date)
    else
      data_report = Incident.report(id, params[:dinitial].to_date, params[:dfinish].to_date)
    end

    if data_report.present?
      @data_report = data_report
      render layout: false
    else
      redirect_to report_path, flash: { error: 'Dados não encontrados' }
    end
  end
end
