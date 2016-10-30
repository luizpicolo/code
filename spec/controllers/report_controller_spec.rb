require 'rails_helper'

RSpec.describe ReportController, type: :controller do
  login_user
  let(:student) { FactoryGirl.create(:student) }

  describe "GET index" do
    it "should render the report generation form" do
      get :index

      expect(response).to have_http_status(:success)
      expect(response).to render_template('index')
    end
  end

  describe "GET print" do
    context "there is no data" do
      it "should display an error" do
        get :print, params: { school_performace: { student_id: student.id },
                              type: 2, dinitial: "01/01/2010", dfinish: "01/12/2016" }

        expect(flash[:error]).not_to be_nil
      end
    end

    context "there is data" do
      before do
        FactoryGirl.create(:incident, student: student,
                           date_incident: "05/03/2012".to_date)
        FactoryGirl.create(:school_performace, student: student,
                           start_date: "05/03/2012".to_date,
                          finish_date: "05/09/2012".to_date)
      end

      it "should return incident report if user is admin" do
        get :print, params: { school_performace: { student_id: student.id },
                              type: 1, dinitial: "01/01/2010", dfinish: "01/12/2016" }

        expected_report = Incident.report(student.id, "01/01/2010".to_date,
                                          "01/12/2016".to_date)
        expect(assigns(:data_report)).to eq(expected_report)
      end

      it "should return school performance report if user is admin" do
        get :print, params: { school_performace: { student_id: student.id },
                              type: 2, dinitial: "01/01/2010", dfinish: "01/12/2016" }

        expected_report = SchoolPerformace.report(student.id, "01/01/2010".to_date,
                                                  "01/12/2016".to_date)
        expect(assigns(:data_report)).to eq(expected_report)
      end
    end
  end
end
