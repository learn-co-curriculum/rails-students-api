class CohortsController < ApplicationController
  respond_to :json

  def index
    respond_with Cohort.all
  end

  def show
    begin
      respond_with Cohort.find(params[:id])
    rescue
      raise "Invalid ID!"
    end
  end

  def create
    Cohort.create(cohort_params)
    render nothing: :true, status: 201
  end

  def update
    begin
      cohort = Cohort.find(params[:id])
      cohort.update(cohort_params)
      render nothing: :true, status: 202
    rescue
      raise "Invalid ID!"
    end
  end

  def destroy 
    begin
      cohort = Cohort.find(params[:id])
      cohort.destroy
      render nothing: :true, status: 202
    rescue
      raise "Invalid ID!"
    end
  end

  private
    def cohort_params
      params.require(:cohort).permit(:name, :kind)
    end
end
