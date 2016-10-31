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
