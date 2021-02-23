class SemestersController < ApplicationController
  before_action :check_for_lockup

  def index
    @semesters = Semester.order("start_date ASC")
  end

  def show
    @semester = Semester.find(params[:id])
  end

  def new
    @semester = Semester.new
  end

  def create
    @semester = Semester.new(semester_params)
    semester_name = @semester.semester_name

    if @semester.save
      redirect_to(semesters_path, notice: "#{semester_name} added to list!")
    else
      flash[:errors] = "Invalid fields"
      render("new")
    end
  end

  def edit
    @semester = Semester.find(params[:id])
  end

  def update
    @semester = Semester.find(params[:id])
    if @semester.update(semester_params)
      redirect_to(semesters_path, notice: "#{@semester.semester_name} information updated!")
    else
      flash[:errors] = "Invalid fields"
      render("edit")
    end
  end

  def delete
    @semester = Semester.find(params[:id])
  end

  def destroy
    @semester = Semester.find(params[:id])
    @semester.destroy
    redirect_to(semesters_path, :flash => { notice: "Semester deleted from list!" })
  end

  private

  def semester_params
    params.require(:semester).permit(:semester_name, :start_date, :end_date, :dues_deadline)
  end
end
