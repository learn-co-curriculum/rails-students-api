class StudentsController < ApplicationController
  respond_to :json

  def index
    if !params[:cohort_id]
      respond_with Student.all
    else
      respond_with Cohort.find(params[:cohort_id]).students
    end
  end

  def show
    begin
      @student = Student.find(params[:id])
    rescue
      raise "Invalid Student ID!"
    end
  end
end
