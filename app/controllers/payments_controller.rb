class PaymentsController < ApplicationController
  # before_action :check_for_lockup

  ### READ ###
  def index
    @payments = Payment.order("created_at DESC")
  end

  def show
    @payment = Payment.find(params[:id])
  end

  ### CREATE ###
  def new
    @payment = Payment.new
    @members = Member.order("name ASC")
    @semesters = Semester.order("start_date DESC")
    @officers = Officer.order("name ASC")

    @payment.payment_date = DateTime.now
  end

  def create
    @members = Member.order("name ASC")
    @semesters = Semester.order("start_date DESC")
    @officers = Officer.order("name ASC")

    @payment = Payment.new(payment_params)

    @payment.payment_date = DateTime.now

    # Make sure associated member, officer, and semester exist
    if valid_relations(@payment)
      if @payment.save
        flash[:notice] = "Payment Successfully Created!"
        redirect_to(payments_path)
      else
        flash[:errors] = "Invalid fields"
        render("new")
      end
    else
      flash[:errors] = "Invalid officer, member or semester"
      render("new")
    end
  end

  ### UPDATE ###
  def edit
    @payment = Payment.find(params[:id])
    @members = Member.order("name ASC")
    @semesters = Semester.order("start_date DESC")
    @officers = Officer.order("name ASC")
  end

  def update
    @payment = Payment.find(params[:id])
    @members = Member.order("name ASC")
    @semesters = Semester.order("start_date DESC")
    @officers = Officer.order("name ASC")

    if @payment.update(payment_params)
      flash[:notice] = "Payment Successfully Updated!"
      redirect_to(payments_path)
    else
      flash[:errors] = "Invalid fields"
      render("edit")
    end
  end

  ### DELETE ###
  def delete
    @payment = Payment.find(params[:id])
  end

  def destroy
    @payment = Payment.find(params[:id])
    @payment.destroy
    flash[:notice] = "Payment has been deleted"
    redirect_to(payments_path)
  end

  private

  def payment_params
    params.require(:payment).permit(:member_id, :semester_id, :officer_id, :payment_amount)
  end

  def valid_relations(form_record)
    semester_exists = Semester.exists?(id: form_record.semester_id)
    officer_exists = Officer.exists?(id: form_record.officer_id)
    member_exists = Member.exists?(id: form_record.member_id)

    if semester_exists && officer_exists && member_exists
      true
    else
      false
    end
  end
end
