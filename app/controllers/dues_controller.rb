class DuesController < ApplicationController
  # before_action :check_for_lockup

  ### READ ###
  def index
    @selectedSemester = params[:semester]
    @selectedSemester = "All" if @selectedSemester == nil

    @payments = Due.filter_on_semester(@selectedSemester)

    @total = Due.get_total(@payments)
  end

  def show
    @payment = Due.find(params[:id])
  end

  ### CREATE ###
  def new
    @payment = Due.new
    @members = Member.order("name ASC")
    @semesters = Semester.order("start_date DESC")
    @officers = Officer.order("name ASC")

    @payment.payment_date = DateTime.now
    if params[:member_id] != nil
      @payment.member_id = params[:member_id]
    end

  end

  def create
    @members = Member.order("name ASC")
    @semesters = Semester.order("start_date DESC")
    @officers = Officer.order("name ASC")

    @payment = Due.new(due_params)

    @payment.payment_date = DateTime.now
	
    # Make sure associated member, officer, and semester exist
    if valid_relations(@payment)
      if @payment.save
        flash[:notice] = "Payment Successfully Created!"
        redirect_to(receipt_payment_url(:id => @payment))
      else
        flash[:errors] = "Invalid fields"
        render("new")
      end
    else
      flash[:errors] = "Invalid officer, member or semester"
      render("new")
    end
  end

  def receipt
    @payment = Payment.find(params[:id])
  end

  ### UPDATE ###
  def edit
    @payment = Due.find(params[:id])
    @members = Member.order("name ASC")
    @semesters = Semester.order("start_date DESC")
    @officers = Officer.order("name ASC")
  end

  def update
    @payment = Due.find(params[:id])
    @members = Member.order("name ASC")
    @semesters = Semester.order("start_date DESC")
    @officers = Officer.order("name ASC")

    if @payment.update(due_params)
      flash[:notice] = "Payment Successfully Updated!"
      redirect_to(dues_path)
    else
      flash[:errors] = "Invalid fields"
      render("edit")
    end
  end

  ### DELETE ###
  def delete
    @payment = Due.find(params[:id])
  end

  def destroy
    @payment = Due.find(params[:id])
    @payment.destroy
    flash[:notice] = "Payment has been deleted"
    redirect_to(dues_path)
  end

  private

  def due_params
    params.require(:due).permit(:member_id, :semester_id_1, :semester_id_2, :officer_id, :payment_amount, :payment_date)
  end

  def valid_relations(form_record)
    semester_1_exists = Semester.exists?(id: form_record.semester_id_1)
	semester_2_exists = Semester.exists?(id: form_record.semester_id_2) || form_record.semester_id_2.nil?
    officer_exists = Officer.exists?(id: form_record.officer_id)
    member_exists = Member.exists?(id: form_record.member_id)
	
    if semester_1_exists && semester_2_exists && officer_exists && member_exists
      true
    else
      false
    end
  end
end
